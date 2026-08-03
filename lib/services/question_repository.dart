import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data/question_bank.dart';
import '../data/question_mapper.dart';
import '../models/question.dart';

/// Carga el banco con estrategia asset-first (barata en Firestore).
///
/// 1) Siempre usa el seed embebido (0 lecturas de preguntas).
/// 2) Lee solo `meta/question_bank` (1 lectura).
/// 3) Si la nube tiene versión/conteo mayor, entonces sí descarga `questions`.
class QuestionRepository {
  QuestionRepository({FirebaseFirestore? firestore})
      : _firestoreOverride = firestore;

  final FirebaseFirestore? _firestoreOverride;

  int cloudCount = 0;
  int assetCount = 0;
  String source = 'local';
  double? assetVersion;
  double? cloudVersion;

  FirebaseFirestore? get _db {
    if (_firestoreOverride != null) return _firestoreOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFirestore.instance;
  }

  Future<void> loadIntoBank() async {
    cloudCount = 0;
    assetCount = 0;
    assetVersion = null;
    cloudVersion = null;

    final assetPack = await _loadAssetSeed();
    if (assetPack.items.isNotEmpty) {
      QuestionBank.replaceRemote(assetPack.items);
      assetCount = assetPack.items.length;
      assetVersion = assetPack.version;
      source = 'asset';
      debugPrint(
        'QuestionRepository: $assetCount ítems desde asset '
        '(v=${assetVersion ?? "?"})',
      );
    }

    try {
      final meta = await _loadBankMeta();
      if (meta != null) {
        cloudVersion = meta.version;
        final needsCloud = _cloudIsNewer(
          assetVersion: assetVersion,
          assetCount: assetCount,
          cloudVersion: meta.version,
          cloudCount: meta.count,
        );
        if (!needsCloud) {
          debugPrint(
            'QuestionRepository: meta en sync '
            '(cloud v=${meta.version}, count=${meta.count}) · sin bulk read',
          );
          if (assetCount > 0) return;
        } else {
          final cloud = await _loadCloud();
          if (cloud.isNotEmpty) {
            QuestionBank.replaceRemote(cloud);
            cloudCount = cloud.length;
            source = 'firestore';
            debugPrint(
              'QuestionRepository: $cloudCount ítems desde Firestore '
              '(nube más nueva)',
            );
            return;
          }
        }
      }
    } catch (e) {
      debugPrint('QuestionRepository meta/cloud: $e');
    }

    if (assetCount > 0) {
      source = 'asset';
      return;
    }

    QuestionBank.clearRemote();
    source = 'local';
  }

  /// True si conviene pagar el bulk read de `questions`.
  bool _cloudIsNewer({
    required double? assetVersion,
    required int assetCount,
    required double? cloudVersion,
    required int cloudCount,
  }) {
    if (assetCount <= 0) return true;
    if (cloudCount > assetCount) return true;
    if (assetVersion == null || cloudVersion == null) {
      // Sin versión local comparable: no forzar bulk (evita costo).
      return false;
    }
    return cloudVersion > assetVersion + 0.0001;
  }

  Future<_BankMeta?> _loadBankMeta() async {
    final db = _db;
    if (db == null) return null;

    final snap = await db.collection('meta').doc('question_bank').get();
    if (!snap.exists) return null;
    final data = snap.data();
    if (data == null) return null;

    final versionRaw = data['version'];
    final countRaw = data['count'];
    final version = versionRaw is num ? versionRaw.toDouble() : null;
    final count = countRaw is num ? countRaw.toInt() : 0;
    return _BankMeta(version: version, count: count);
  }

  Future<List<Question>> _loadCloud() async {
    final db = _db;
    if (db == null) return const [];

    final snap = await db
        .collection('questions')
        .where('published', isEqualTo: true)
        .limit(2000)
        .get();

    final items = <Question>[];
    for (final doc in snap.docs) {
      final data = doc.data();
      data['id'] = data['id'] ?? doc.id;
      final mapped = QuestionMapper.fromMap(data);
      if (mapped != null) items.add(mapped);
    }
    return items;
  }

  Future<_AssetPack> _loadAssetSeed() async {
    try {
      final raw =
          await rootBundle.loadString('assets/seed/questions_v1.json');
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final list = decoded['items'] as List? ?? const [];
      final versionRaw = decoded['version'];
      final version = versionRaw is num ? versionRaw.toDouble() : null;
      final items = <Question>[];
      for (final entry in list) {
        if (entry is! Map) continue;
        final mapped =
            QuestionMapper.fromMap(Map<String, dynamic>.from(entry));
        if (mapped != null) items.add(mapped);
      }
      return _AssetPack(items: items, version: version);
    } catch (e) {
      debugPrint('QuestionRepository asset: $e');
      return const _AssetPack(items: [], version: null);
    }
  }
}

class _BankMeta {
  const _BankMeta({required this.version, required this.count});

  final double? version;
  final int count;
}

class _AssetPack {
  const _AssetPack({required this.items, required this.version});

  final List<Question> items;
  final double? version;
}

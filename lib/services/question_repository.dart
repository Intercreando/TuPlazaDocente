import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../data/question_bank.dart';
import '../data/question_mapper.dart';
import '../models/question.dart';

/// Carga el banco: Firestore → asset seed → bundle local.
class QuestionRepository {
  QuestionRepository({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  int cloudCount = 0;
  int assetCount = 0;
  String source = 'local';

  Future<void> loadIntoBank() async {
    try {
      final cloud = await _loadCloud();
      if (cloud.isNotEmpty) {
        QuestionBank.replaceRemote(cloud);
        cloudCount = cloud.length;
        source = 'firestore';
        debugPrint('QuestionRepository: $cloudCount ítems desde Firestore');
        return;
      }
    } catch (e) {
      debugPrint('QuestionRepository cloud: $e');
    }

    try {
      final asset = await _loadAssetSeed();
      if (asset.isNotEmpty) {
        QuestionBank.replaceRemote(asset);
        assetCount = asset.length;
        source = 'asset';
        debugPrint('QuestionRepository: $assetCount ítems desde asset seed');
        return;
      }
    } catch (e) {
      debugPrint('QuestionRepository asset: $e');
    }

    QuestionBank.clearRemote();
    source = 'local';
  }

  Future<List<Question>> _loadCloud() async {
    final snap = await _db
        .collection('questions')
        .where('published', isEqualTo: true)
        .limit(500)
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

  Future<List<Question>> _loadAssetSeed() async {
    final raw = await rootBundle.loadString('assets/seed/questions_v1.json');
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final list = decoded['items'] as List? ?? const [];
    final items = <Question>[];
    for (final entry in list) {
      if (entry is! Map) continue;
      final mapped =
          QuestionMapper.fromMap(Map<String, dynamic>.from(entry));
      if (mapped != null) items.add(mapped);
    }
    return items;
  }
}

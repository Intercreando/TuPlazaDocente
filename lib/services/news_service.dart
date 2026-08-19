import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../models/news_item.dart';
import '../utils/compress_news_image.dart';

/// Lectura pública y CRUD admin de noticias.
class NewsService {
  NewsService({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
    FirebaseStorage? storage,
  }) : _firestoreOverride = firestore,
       _functionsOverride = functions,
       _storageOverride = storage;

  final FirebaseFirestore? _firestoreOverride;
  final FirebaseFunctions? _functionsOverride;
  final FirebaseStorage? _storageOverride;

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception('Firebase no está disponible.');
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  FirebaseFirestore? get _db {
    if (_firestoreOverride != null) return _firestoreOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFirestore.instance;
  }

  FirebaseStorage? get _storage {
    if (_storageOverride != null) return _storageOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseStorage.instance;
  }

  Future<List<NewsItem>> listPublished({int limit = 20}) async {
    final db = _db;
    if (db == null) return const [];
    try {
      final snap = await db
          .collection('news')
          .where('published', isEqualTo: true)
          .limit(40)
          .get();
      final items = snap.docs
          .map((d) => NewsItem.fromMap(d.id, d.data()))
          .toList();
      items.sort((a, b) {
        if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
        return (b.publishedAtMs ?? b.updatedAtMs ?? 0).compareTo(
          a.publishedAtMs ?? a.updatedAtMs ?? 0,
        );
      });
      return items.take(limit).toList();
    } catch (e) {
      debugPrint('NewsService listPublished: $e');
      return const [];
    }
  }

  Future<NewsItem?> getById(String id) async {
    final db = _db;
    if (db == null || id.isEmpty) return null;
    try {
      final snap = await db.collection('news').doc(id).get();
      if (!snap.exists || snap.data() == null) return null;
      final item = NewsItem.fromMap(snap.id, snap.data()!);
      return item.published ? item : null;
    } catch (e) {
      debugPrint('NewsService getById: $e');
      return null;
    }
  }

  /// Busca por slug (la URL pública) y, si no existe, por id: los enlaces
  /// antiguos apuntaban al identificador del documento.
  Future<NewsItem?> getBySlugOrId(String key) async {
    final db = _db;
    if (db == null || key.isEmpty) return null;
    try {
      final snap = await db
          .collection('news')
          .where('slug', isEqualTo: key)
          .where('published', isEqualTo: true)
          .limit(1)
          .get();
      if (snap.docs.isNotEmpty) {
        final doc = snap.docs.first;
        return NewsItem.fromMap(doc.id, doc.data());
      }
    } catch (e) {
      debugPrint('NewsService getBySlugOrId: $e');
    }
    return getById(key);
  }

  Future<List<NewsItem>> adminList() async {
    try {
      final callable = _functions.httpsCallable('adminListNews');
      final result = await callable.call();
      final raw = result.data;
      if (raw is! Map) return const [];
      final items = Map<String, dynamic>.from(raw)['items'];
      if (items is! List) return const [];
      return items.whereType<Map>().map((e) {
        final data = Map<String, dynamic>.from(e);
        return NewsItem.fromMap('${data['id'] ?? ''}', data);
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      throw Exception(_friendly(e));
    }
  }

  Future<String> adminUpsert({
    String? id,
    required String title,
    required String summary,
    required String body,
    required String tag,
    String slug = '',
    String? imageUrl,
    List<NewsLink> links = const [],
    bool published = true,
    bool pinned = false,
  }) async {
    try {
      final callable = _functions.httpsCallable('adminUpsertNews');
      final result = await callable.call(<String, dynamic>{
        'id': id,
        'slug': slug.trim(),
        'title': title.trim(),
        'summary': summary.trim(),
        'body': body.trim(),
        'tag': tag,
        'imageUrl': imageUrl,
        'links': links.map((e) => e.toMap()).toList(),
        'published': published,
        'pinned': pinned,
      });
      final raw = result.data;
      if (raw is Map && raw['id'] != null) return '${raw['id']}';
      return id ?? '';
    } on FirebaseFunctionsException catch (e) {
      throw Exception(_friendly(e));
    }
  }

  Future<void> adminDelete(String id) async {
    try {
      final callable = _functions.httpsCallable('adminDeleteNews');
      await callable.call(<String, dynamic>{'id': id});
    } on FirebaseFunctionsException catch (e) {
      throw Exception(_friendly(e));
    }
  }

  Future<String> uploadCover({
    required String newsId,
    required Uint8List bytes,
  }) async {
    final storage = _storage;
    if (storage == null) {
      throw Exception(
        'Firebase Storage no está disponible. Actívalo en la consola de Firebase.',
      );
    }
    final compressed = compressNewsCoverBytes(bytes);
    final ref = storage.ref('news/$newsId/cover.jpg');
    await ref.putData(compressed, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }

  String _friendly(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'No tienes permiso de administrador.';
      case 'unauthenticated':
        return 'Inicia sesión con tu cuenta admin.';
      case 'not-found':
        return e.message ?? 'Noticia no encontrada.';
      case 'invalid-argument':
        return e.message ?? 'Revisa título y resumen.';
      default:
        return e.message ?? 'Error del servidor (${e.code}).';
    }
  }
}

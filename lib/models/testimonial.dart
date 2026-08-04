/// Opinión pública de la comunidad (moderada).
class Testimonial {
  const Testimonial({
    required this.id,
    required this.text,
    required this.displayName,
    required this.source,
    required this.approved,
    this.roleLabel,
    this.createdAt,
    this.uid,
  });

  final String id;
  final String text;
  final String displayName;
  final String source; // seed | user
  final bool approved;
  final String? roleLabel;
  final DateTime? createdAt;
  final String? uid;

  bool get isSeed => source == 'seed';

  factory Testimonial.fromMap(String id, Map<String, dynamic> data) {
    final createdRaw = data['createdAt'];
    DateTime? createdAt;
    if (createdRaw is DateTime) {
      createdAt = createdRaw;
    } else if (createdRaw != null) {
      try {
        // Firestore Timestamp en cliente.
        createdAt = (createdRaw as dynamic).toDate() as DateTime?;
      } catch (_) {
        createdAt = null;
      }
    }
    return Testimonial(
      id: id,
      text: (data['text'] as String? ?? '').trim(),
      displayName: (data['displayName'] as String? ?? 'Aspirante').trim(),
      source: (data['source'] as String? ?? 'user').trim(),
      approved: data['approved'] == true,
      roleLabel: (data['roleLabel'] as String?)?.trim(),
      createdAt: createdAt,
      uid: data['uid'] as String?,
    );
  }

  Map<String, dynamic> toSeedMap() => {
        'text': text,
        'displayName': displayName,
        'roleLabel': roleLabel,
        'source': 'seed',
        'approved': true,
        'uid': null,
      };
}

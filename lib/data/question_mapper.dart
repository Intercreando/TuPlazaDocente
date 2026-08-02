import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Convierte documentos Firestore / JSON seed al modelo [Question].
abstract final class QuestionMapper {
  static Question? fromMap(Map<String, dynamic> raw) {
    try {
      final id = raw['id']?.toString() ?? '';
      if (id.isEmpty) return null;

      final options =
          (raw['options'] as List?)?.map((e) => e.toString()).toList();
      if (options == null || options.length < 2) return null;

      final correctIndex = (raw['correctIndex'] as num?)?.toInt() ?? 0;
      final difficultyName = raw['difficulty']?.toString() ?? 'intermedio';
      final difficulty = QuestionDifficulty.values.firstWhere(
        (d) => d.name == difficultyName,
        orElse: () => QuestionDifficulty.fromLevel(
          (raw['dificultad'] as num?)?.toInt() ?? 2,
        ),
      );

      final specialtyRaw = raw['specialtyTags'] as List? ?? const [];
      final specialtyTags = specialtyRaw
          .map((e) => _especialidad(e.toString()))
          .whereType<Especialidad>()
          .toList();

      final distractorsRaw = raw['distractorAnalysis'];
      final distractors = <int, String>{};
      if (distractorsRaw is Map) {
        distractorsRaw.forEach((key, value) {
          final index = int.tryParse(key.toString());
          if (index != null && value != null) {
            distractors[index] = value.toString();
          }
        });
      }

      final tagsRaw = raw['knowledgeTags'] as List? ?? const [];
      final knowledgeTags = <KnowledgeTag>[];
      for (final tag in tagsRaw) {
        if (tag is! Map) continue;
        final codeName = tag['code']?.toString();
        if (codeName == null) continue;
        final code = _knowledgeCode(codeName);
        if (code == null) continue;
        knowledgeTags.add(
          KnowledgeTag(
            code: code,
            articleOrFocus: tag['focus']?.toString(),
          ),
        );
      }

      final moduleName = raw['module']?.toString();
      final module = _module(moduleName);

      return Question(
        id: id,
        pillar: _pillar(raw['pillar']?.toString()),
        topic: raw['topic']?.toString() ?? raw['subtopic']?.toString() ?? 'General',
        stem: raw['stem']?.toString() ?? '',
        options: options,
        correctIndex: correctIndex.clamp(0, options.length - 1),
        explanation: raw['explanation']?.toString() ?? '',
        difficulty: difficulty,
        isCaseStudy: raw['isCaseStudy'] as bool? ?? false,
        caseContext: raw['caseContext']?.toString(),
        normativeRefs: (raw['normativeRefs'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        specialtyTags: specialtyTags,
        module: module,
        subtopic: raw['subtopic']?.toString(),
        targetCargo: _especialidad(raw['targetCargo']?.toString()),
        knowledgeTags: knowledgeTags,
        normativeJustification: raw['normativeJustification']?.toString(),
        theoreticalJustification: raw['theoreticalJustification']?.toString(),
        distractorAnalysis: distractors,
        recommendedSeconds: (raw['recommendedSeconds'] as num?)?.toInt() ??
            (raw['tiempo_recomendado_seg'] as num?)?.toInt(),
      );
    } catch (_) {
      return null;
    }
  }

  static CompetencyPillar _pillar(String? name) {
    return CompetencyPillar.values.firstWhere(
      (p) => p.name == name,
      orElse: () => CompetencyPillar.pedagogico,
    );
  }

  static Especialidad? _especialidad(String? name) {
    if (name == null || name.isEmpty) return null;
    for (final e in Especialidad.values) {
      if (e.name == name) return e;
    }
    return null;
  }

  static KnowledgeCode? _knowledgeCode(String name) {
    for (final code in KnowledgeCode.values) {
      if (code.name == name) return code;
    }
    return null;
  }

  static ContentModule? _module(String? name) {
    if (name == null || name.isEmpty) return null;
    for (final module in ContentModule.values) {
      if (module.name == name || module.label == name) return module;
    }
    return null;
  }
}

import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Textos del andamiaje (sin IA): por qué falló lo marcado, y la clave al cerrar.
abstract final class TutorScaffoldCopy {
  /// Explica la opción marcada. No revela la correcta.
  static String hintFor(Question question, int chosenIndex) {
    return whyMarkedWrong(question, chosenIndex);
  }

  /// Nombre lo que eligió + por qué no aplica en este caso.
  static String whyMarkedWrong(Question question, int chosenIndex) {
    if (question.isCorrect(chosenIndex)) return '';
    if (chosenIndex < 0 || chosenIndex >= question.options.length) {
      return '';
    }
    final marked = _clipOption(question.options[chosenIndex]);
    final why = _whyBody(question, chosenIndex);
    return 'Marcaste «$marked». $why';
  }

  /// Regla reutilizable para el siguiente simulacro.
  static String claveFor(Question question) {
    if (question.knowledgeTags.isNotEmpty) {
      return _claveByCode(question.knowledgeTags.first.code);
    }
    return _claveByPillar(question.pillar);
  }

  static String _whyBody(Question question, int chosenIndex) {
    final raw = question.distractorAnalysis[chosenIndex]?.trim() ?? '';
    if (raw.isNotEmpty && !_isGenericDistractor(raw)) {
      return raw;
    }
    if (question.knowledgeTags.isNotEmpty) {
      return _whyByCode(question.knowledgeTags.first.code);
    }
    return _whyByPillar(question.pillar);
  }

  static bool _isGenericDistractor(String raw) {
    final text = raw.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
    return text.contains('opción cercana o habitual') ||
        text.contains('no articula el referente') ||
        text.contains('la evidencia o la instancia');
  }

  static String _clipOption(String raw) {
    final text = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (text.length <= 110) return text;
    return '${text.substring(0, 107).trim()}…';
  }

  static String _whyByCode(KnowledgeCode code) {
    switch (code) {
      case KnowledgeCode.decreto1290:
        return 'Esa actuación se adelanta a la medida. En evaluación primero '
            'van los criterios, la evidencia y el debido proceso.';
      case KnowledgeCode.decreto1421:
        return 'Esa vía no diseña el apoyo. Ante una barrera, el PIAR y los '
            'ajustes razonables van antes que excluir o bajar la exigencia.';
      case KnowledgeCode.ley1620:
        return 'Esa respuesta improvisa o minimiza. La convivencia pide '
            'activar la ruta según el tipo de situación.';
      case KnowledgeCode.guiaMen49:
        return 'Esa vía usa el criterio del momento. El manual se aplica con '
            'el protocolo, no con lo que «parezca» justo hoy.';
      case KnowledgeCode.guiaMen51:
        return 'Esa actuación trata todas las situaciones igual. Hay que '
            'clasificar (I, II o III) y seguir esa ruta.';
      case KnowledgeCode.decreto1278:
        return 'Esa medida se salta el conducto. El estatuto distingue el tipo '
            'de falta antes de una sanción extrema.';
      case KnowledgeCode.ley115:
        return 'Esa opción privilegia el gusto particular. Mandan el PEI y '
            'los fines de la ley.';
      case KnowledgeCode.decreto1860:
        return 'Esa decisión se toma por fuera de las instancias. El gobierno '
            'escolar no se resuelve en un pasillo.';
      case KnowledgeCode.guiaMen50:
        return 'Esa vía escolariza de más. En inicial pesan el cuidado y el '
            'juego pedagógico, no la rigidez de primaria.';
      case KnowledgeCode.vygotsky:
        return 'Esa opción o lo deja solo o le hace la tarea. El andamiaje '
            'es una ayuda ajustada para que el estudiante haga.';
      case KnowledgeCode.ausubel:
        return 'Esa vía ignora lo que el estudiante ya sabe. El contenido '
            'nuevo tiene que anclarse en saberes previos.';
      case KnowledgeCode.piaget:
        return 'Esa tarea no calza con el estadio. No se pide operación '
            'formal a quien aún no la construye.';
      case KnowledgeCode.bruner:
        return 'Esa opción entrega el resultado o abandona. El descubrimiento '
            'guiado estructura el problema, no lo resuelve por el otro.';
      case KnowledgeCode.ebc:
        return 'Esa vía trata los estándares como lista de temas. Describen '
            'el desempeño esperado, no el índice del libro.';
      case KnowledgeCode.dba:
        return 'Esa actuación no apunta a la evidencia de aprendizaje. El '
            'DBA es lo que el estudiante debe poder mostrar.';
      case KnowledgeCode.lineamientos:
        return 'Esa opción se queda en contenidos sueltos. El área tiene un '
            'enfoque; la secuencia debe respetarlo.';
    }
  }

  static String _whyByPillar(CompetencyPillar pillar) {
    switch (pillar) {
      case CompetencyPillar.aptitudNumerica:
        return 'Esa cuenta suele usar el número que más se ve, no el que pide '
            'el enunciado: ¿total, diferencia, porcentaje o proporción?';
      case CompetencyPillar.lecturaCritica:
        return 'Esa lectura se adelanta al texto. Responde a lo que pregunta '
            'el ítem, no a lo que tú inferirías.';
      case CompetencyPillar.pedagogico:
        return 'Esa actuación puede servir en otro momento, pero aquí se '
            'adelanta o se va al extremo. Gana lo formativo y normativo.';
      case CompetencyPillar.comportamental:
        return 'Esa vía se va a un extremo (dejar pasar o escalar). Gana la '
            'actuación proporcional, con diálogo y fundamento.';
    }
  }

  static String _claveByCode(KnowledgeCode code) {
    switch (code) {
      case KnowledgeCode.decreto1290:
        return 'En evaluación, primero criterios, evidencia y debido proceso; '
            'la sanción o la promoción no se improvisan.';
      case KnowledgeCode.decreto1421:
        return 'Ante una barrera, el PIAR y los ajustes razonables van antes '
            'que excluir o bajar la exigencia sin diseño.';
      case KnowledgeCode.ley1620:
        return 'Convivencia: activa la ruta según el tipo de situación; '
            'no improvises ni minimices.';
      case KnowledgeCode.guiaMen49:
        return 'El manual de convivencia se aplica con el protocolo, no con '
            'el criterio del momento.';
      case KnowledgeCode.guiaMen51:
        return 'Clasifica la situación (I, II o III) y sigue la ruta; no '
            'todas se resuelven igual.';
      case KnowledgeCode.decreto1278:
        return 'El estatuto distingue el tipo de falta y el conducto; no se '
            'salta a una medida extrema por impulso.';
      case KnowledgeCode.ley115:
        return 'El PEI y los fines de la ley mandan sobre el gusto particular '
            'del docente.';
      case KnowledgeCode.decreto1860:
        return 'Gobierno escolar: se decide en las instancias, no en un pasillo.';
      case KnowledgeCode.guiaMen50:
        return 'En educación inicial, el cuidado y el juego pedagógico van '
            'antes que la escolarización rígida.';
      case KnowledgeCode.vygotsky:
        return 'Andamiaje en la ZDP: ayuda ajustada para que el estudiante '
            'haga, no para hacerle la tarea.';
      case KnowledgeCode.ausubel:
        return 'Parte de los saberes previos; no introduzcas el contenido '
            'como si la mente estuviera vacía.';
      case KnowledgeCode.piaget:
        return 'Ajusta la tarea al estadio; no pidas operación formal a quien '
            'aún no la construye.';
      case KnowledgeCode.bruner:
        return 'Descubrimiento guiado: estructura el problema; no entregues '
            'el resultado ni abandones.';
      case KnowledgeCode.ebc:
        return 'Los estándares describen el desempeño esperado, no un listado '
            'de temas para dictar.';
      case KnowledgeCode.dba:
        return 'El DBA es el aprendizaje a evidenciar; diseña la clase hacia '
            'esa evidencia.';
      case KnowledgeCode.lineamientos:
        return 'El área tiene un enfoque, no solo contenidos; la secuencia '
            'debe respetarlo.';
    }
  }

  static String _claveByPillar(CompetencyPillar pillar) {
    switch (pillar) {
      case CompetencyPillar.aptitudNumerica:
        return 'Lee qué pide (total, diferencia, porcentaje) y opera con ese '
            'dato, no con el más visible.';
      case CompetencyPillar.lecturaCritica:
        return 'Distingue lo que el texto dice de lo que tú inferirías; '
            'responde a la pregunta, no al tema.';
      case CompetencyPillar.pedagogico:
        return 'En el concurso gana la actuación formativa y normativa, no '
            'la más rápida ni la más dura.';
      case CompetencyPillar.comportamental:
        return 'Proporción y diálogo: ni ignorar ni escalar; actúa con '
            'fundamento y respeto.';
    }
  }
}

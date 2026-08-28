import '../models/enums.dart';
import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Textos del andamiaje (sin IA): pista al fallar y clave al cerrar el caso.
abstract final class TutorScaffoldCopy {
  /// Pista del distractor o, si falta, del pilar. Nunca revela la correcta.
  static String hintFor(Question question, int chosenIndex) {
    if (question.isCorrect(chosenIndex)) return '';
    final raw = question.distractorAnalysis[chosenIndex]?.trim() ?? '';
    if (raw.isNotEmpty) return raw;
    return _hintByPillar(question.pillar);
  }

  /// Regla reutilizable para el siguiente simulacro.
  static String claveFor(Question question) {
    if (question.knowledgeTags.isNotEmpty) {
      return _claveByCode(question.knowledgeTags.first.code);
    }
    return _claveByPillar(question.pillar);
  }

  static String _hintByPillar(CompetencyPillar pillar) {
    switch (pillar) {
      case CompetencyPillar.aptitudNumerica:
        return 'Esa vía suele operar el número que más se ve. Antes de '
            'recalcular, nombra qué pide el enunciado: ¿total, diferencia, '
            'porcentaje o proporción?';
      case CompetencyPillar.lecturaCritica:
        return 'Esa lectura se adelanta al texto. Vuelve a la pregunta: '
            '¿qué pide exactamente? Distingue lo dicho de lo que inferirías.';
      case CompetencyPillar.pedagogico:
        return 'Esa actuación puede servir en otro momento, pero aquí no es '
            'la exigida. Piensa qué harías primero según la norma o el '
            'enfoque, no lo más rápido ni lo más duro.';
      case CompetencyPillar.comportamental:
        return 'Esa vía se va a un extremo (dejar pasar o escalar). En el '
            'concurso gana la actuación proporcional, con diálogo y fundamento.';
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

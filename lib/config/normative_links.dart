import '../models/knowledge_taxonomy.dart';
import '../models/question.dart';

/// Fuente normativa oficial que se puede abrir en el navegador.
class NormativeSource {
  const NormativeSource({
    required this.code,
    required this.label,
    required this.url,
  });

  final String code;
  final String label;
  final String url;

  Uri get uri => Uri.parse(url);
}

/// Catálogo central: código canónico → documento oficial (Función Pública / MEN).
///
/// Preferimos el documento completo (estable). Anclar artículos exactos
/// queda para una fase posterior cuando la fuente lo permita de forma fiable.
abstract final class NormativeLinks {
  static const Map<KnowledgeCode, NormativeSource> byCode = {
    KnowledgeCode.ley115: NormativeSource(
      code: 'ley115',
      label: 'Ley 115 de 1994',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=292',
    ),
    KnowledgeCode.decreto1860: NormativeSource(
      code: 'decreto1860',
      label: 'Decreto 1860 de 1994',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=1386',
    ),
    KnowledgeCode.decreto1278: NormativeSource(
      code: 'decreto1278',
      label: 'Decreto 1278 de 2002',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=5353',
    ),
    KnowledgeCode.decreto1290: NormativeSource(
      code: 'decreto1290',
      label: 'Decreto 1290 de 2009',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=35954',
    ),
    KnowledgeCode.ley1620: NormativeSource(
      code: 'ley1620',
      label: 'Ley 1620 de 2013',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=52287',
    ),
    KnowledgeCode.decreto1421: NormativeSource(
      code: 'decreto1421',
      label: 'Decreto 1421 de 2017',
      url:
          'https://www.funcionpublica.gov.co/eva/gestornormativo/norma.php?i=82311',
    ),
    KnowledgeCode.guiaMen49: NormativeSource(
      code: 'guiaMen49',
      label: 'Guía MEN 49',
      url:
          'https://contenidos.mineducacion.gov.co/ntg/men/pdf/Guia%20No.%2049.pdf',
    ),
    KnowledgeCode.guiaMen50: NormativeSource(
      code: 'guiaMen50',
      label: 'Guía MEN 50',
      url:
          'https://www.mineducacion.gov.co/1759/articles-341880_archivo_pdf_guia_50.pdf',
    ),
    KnowledgeCode.guiaMen51: NormativeSource(
      code: 'guiaMen51',
      label: 'Guía MEN 51',
      url:
          'https://www.mineducacion.gov.co/1780/articles-341880_archivo_pdf_guia_51.pdf',
    ),
    KnowledgeCode.ebc: NormativeSource(
      code: 'ebc',
      label: 'Estándares Básicos de Competencias',
      url:
          'https://www.mineducacion.gov.co/1621/articles-340021_recurso_1.pdf',
    ),
    KnowledgeCode.dba: NormativeSource(
      code: 'dba',
      label: 'Derechos Básicos de Aprendizaje',
      url: 'https://www.colombiaaprende.edu.co/contenidos/coleccion/dba',
    ),
    KnowledgeCode.lineamientos: NormativeSource(
      code: 'lineamientos',
      label: 'Lineamientos curriculares MEN',
      url:
          'https://www.mineducacion.gov.co/portal/Educacion-basica/Lineamientos/',
    ),
  };

  /// Fuentes abribles para un ítem (códigos + textos legacy en normativeRefs).
  static List<NormativeSource> forQuestion(Question question) {
    final seen = <String>{};
    final out = <NormativeSource>[];

    void add(NormativeSource? source) {
      if (source == null) return;
      if (!seen.add(source.code)) return;
      out.add(source);
    }

    for (final tag in question.knowledgeTags) {
      add(byCode[tag.code]);
    }

    for (final ref in question.normativeRefs) {
      add(resolveFreeText(ref));
    }

    return out;
  }

  /// Resuelve textos libres del estilo "Decreto 1290 de 2009" o "ley1620".
  static NormativeSource? resolveFreeText(String raw) {
    final t = raw.toLowerCase().trim();
    if (t.isEmpty) return null;

    // Códigos canónicos pegados tal cual.
    for (final code in KnowledgeCode.values) {
      if (t == code.name.toLowerCase()) return byCode[code];
    }

    if (t.contains('1290')) return byCode[KnowledgeCode.decreto1290];
    if (t.contains('1421')) return byCode[KnowledgeCode.decreto1421];
    if (t.contains('1620')) return byCode[KnowledgeCode.ley1620];
    if (t.contains('1278')) return byCode[KnowledgeCode.decreto1278];
    if (t.contains('1860')) return byCode[KnowledgeCode.decreto1860];
    if (RegExp(r'\bley\s*115\b').hasMatch(t) || t.contains('ley general')) {
      return byCode[KnowledgeCode.ley115];
    }
    if (t.contains('guía 49') ||
        t.contains('guia 49') ||
        t.contains('guiamen49') ||
        t.contains('guía men 49') ||
        t.contains('guia men 49')) {
      return byCode[KnowledgeCode.guiaMen49];
    }
    if (t.contains('guía 50') ||
        t.contains('guia 50') ||
        t.contains('guiamen50')) {
      return byCode[KnowledgeCode.guiaMen50];
    }
    if (t.contains('guía 51') ||
        t.contains('guia 51') ||
        t.contains('guiamen51')) {
      return byCode[KnowledgeCode.guiaMen51];
    }
    if (t.contains('dba') || t.contains('derechos básicos')) {
      return byCode[KnowledgeCode.dba];
    }
    if (t.contains('ebc') || t.contains('estándares básicos')) {
      return byCode[KnowledgeCode.ebc];
    }
    if (t.contains('lineamiento')) {
      return byCode[KnowledgeCode.lineamientos];
    }

    return null;
  }
}

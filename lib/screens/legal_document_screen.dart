import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/legal_documents.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';

/// Documento legal (Términos o Privacidad).
enum LegalDocumentKind { terms, privacy }

/// Pantalla de lectura de textos legales.
class LegalDocumentScreen extends StatelessWidget {
  const LegalDocumentScreen({super.key, required this.kind});

  final LegalDocumentKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTerms = kind == LegalDocumentKind.terms;
    final title = isTerms ? 'Términos de uso' : 'Política de privacidad';
    final sections = isTerms ? LegalDocuments.terms : LegalDocuments.privacy;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          tooltip: 'Volver',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: AtmosphericBackground(
        dark: isDark,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 36),
              children: [
                Text(
                  'Última actualización: ${LegalDocuments.lastUpdatedLabel}',
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  isTerms
                      ? 'Condiciones para usar TuPlazaDocente y el acceso Premium.'
                      : 'Cómo tratamos tus datos personales al usar TuPlazaDocente.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                for (final section in sections) ...[
                  Text(section.title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(section.body, style: theme.textTheme.bodyMedium),
                  const SizedBox(height: 16),
                ],
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  'Contacto: ${LegalDocuments.contactEmail}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.canopy,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () => context.push(
                    isTerms ? '/legal/privacy' : '/legal/terms',
                  ),
                  child: Text(
                    isTerms
                        ? 'Ver política de privacidad'
                        : 'Ver términos de uso',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

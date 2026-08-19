import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Cómo sale una noticia a internet y a Google, sin desplegar la app.
class NewsSeoNote extends StatelessWidget {
  const NewsSeoNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.travel_explore_outlined,
                color: AppColors.goldDeep,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'No hace falta desplegar al publicar',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Al guardar como Publicado, la página ya existe en '
            'tuplazadocente.com/noticias/tu-slug/. Copia el enlace público y '
            'úsalo en redes y en Search Console (Solicitar indexación). '
            'No entres al IDE ni ejecutes firebase deploy por cada aviso.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

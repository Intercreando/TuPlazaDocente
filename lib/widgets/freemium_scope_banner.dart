import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';

/// Aviso corto del plan Gratis vs Premium en el hub.
class FreemiumScopeBanner extends StatelessWidget {
  const FreemiumScopeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: AppColors.mist,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => context.push('/premium'),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.gold.withValues(alpha: 0.45)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.goldDeep,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'En Gratis hay cupos y modos con candado',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Libre: racha diaria y reto rápido. Con cupo: 1 práctica/día '
                      'y 1 simulacro/mes. Candado = Casos y especialidad (Premium).',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Ver',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.goldDeep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

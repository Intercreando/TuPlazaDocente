import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/enums.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';

/// Onboarding inteligente: cargo, especialidad y fecha de examen.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _nameController = TextEditingController();
  CargoAspiracion? _cargo;
  Especialidad? _especialidad;
  DateTime? _examDate;
  int _step = 0;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _finish({bool startDiagnostic = false}) async {
    if (_cargo == null || _especialidad == null) {
      setState(() => _error = 'Selecciona cargo y especialidad para continuar.');
      return;
    }
    setState(() => _error = null);
    final state = context.read<AppState>();
    await state.completeOnboarding(
      name: _nameController.text,
      cargo: _cargo!,
      especialidad: _especialidad!,
      examDate: _examDate,
    );
    if (!mounted) return;
    if (startDiagnostic) {
      state.startSession(mode: SessionMode.diagnostic, count: 20);
      context.go('/practice');
    } else {
      context.go('/app');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BrandMark(compact: true),
                    const SizedBox(height: 24),
                    Text('Tu ruta personalizada', style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'En 1 minuto calibramos cargo, especialidad y plan diario.',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    _StepDots(step: _step),
                    const SizedBox(height: 20),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: 280.ms,
                        child: _step == 0
                            ? _StepCargo(
                                key: const ValueKey('cargo'),
                                nameController: _nameController,
                                cargo: _cargo,
                                onCargo: (v) => setState(() {
                                  _cargo = v;
                                  final sugerida = v.especialidadSugerida;
                                  if (sugerida != null) {
                                    _especialidad = sugerida;
                                  }
                                }),
                              )
                            : _step == 1
                                ? _StepEspecialidad(
                                    key: const ValueKey('esp'),
                                    cargo: _cargo,
                                    especialidad: _especialidad,
                                    onSelect: (v) => setState(() => _especialidad = v),
                                  )
                                : _StepExamDate(
                                    key: const ValueKey('date'),
                                    examDate: _examDate,
                                    onPick: () async {
                                      final now = DateTime.now();
                                      final picked = await showDatePicker(
                                        context: context,
                                        firstDate: now,
                                        lastDate: now.add(const Duration(days: 800)),
                                        initialDate: _examDate ?? now.add(const Duration(days: 90)),
                                      );
                                      if (picked != null) {
                                        setState(() => _examDate = picked);
                                      }
                                    },
                                  ),
                      ),
                    ),
                    if (_error != null) ...[
                      Text(
                        _error!,
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.danger),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Row(
                      children: [
                        if (_step > 0)
                          OutlinedButton(
                            onPressed: () => setState(() => _step -= 1),
                            child: const Text('Atrás'),
                          ),
                        const Spacer(),
                        if (_step < 2)
                          FilledButton(
                            onPressed: () {
                              if (_step == 0 && _cargo == null) {
                                setState(() => _error = 'Elige el cargo al que aspiras.');
                                return;
                              }
                              if (_step == 1 && _especialidad == null) {
                                setState(() => _error = 'Elige tu especialidad o nivel.');
                                return;
                              }
                              setState(() {
                                _error = null;
                                _step += 1;
                              });
                            },
                            child: const Text('Continuar'),
                          )
                        else ...[
                          TextButton(
                            onPressed: () => _finish(startDiagnostic: false),
                            child: const Text('Ir al inicio'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            onPressed: () => _finish(startDiagnostic: true),
                            child: const Text('Diagnóstico inicial'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  const _StepDots({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        final active = i <= step;
        return AnimatedContainer(
          duration: 250.ms,
          margin: const EdgeInsets.only(right: 8),
          height: 6,
          width: active ? 34 : 14,
          decoration: BoxDecoration(
            color: active ? AppColors.canopy : AppColors.stroke,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _StepCargo extends StatelessWidget {
  const _StepCargo({
    super.key,
    required this.nameController,
    required this.cargo,
    required this.onCargo,
  });

  final TextEditingController nameController;
  final CargoAspiracion? cargo;
  final ValueChanged<CargoAspiracion> onCargo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: '¿Cómo te llamamos?',
            hintText: 'Tu nombre o apodo',
          ),
        ),
        const SizedBox(height: 18),
        Text('¿A qué cargo aspiras?', style: theme.textTheme.titleMedium),
        const SizedBox(height: 10),
        ...CargoAspiracion.values.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _SelectTile(
              title: c.label,
              selected: cargo == c,
              onTap: () => onCargo(c),
            ),
          ),
        ),
      ],
    );
  }
}

class _StepEspecialidad extends StatelessWidget {
  const _StepEspecialidad({
    super.key,
    this.cargo,
    required this.especialidad,
    required this.onSelect,
  });

  final CargoAspiracion? cargo;
  final Especialidad? especialidad;
  final ValueChanged<Especialidad> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final opciones = cargo != null && cargo!.esGestionInstitucional
        ? const [Especialidad.directivos]
        : Especialidad.values;
    final hint = cargo == CargoAspiracion.rector
        ? 'Para Rector calibramos el banco de Gestión directiva: PEI, gobierno escolar, SIEE y convivencia.'
        : cargo == CargoAspiracion.directivo
            ? 'Para Directivo / Coordinador priorizamos Gestión directiva e liderazgo pedagógico.'
            : null;

    return ListView(
      children: [
        Text('¿Cuál es tu especialidad o nivel?', style: theme.textTheme.titleMedium),
        if (hint != null) ...[
          const SizedBox(height: 8),
          Text(hint, style: theme.textTheme.bodyMedium),
        ],
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: opciones.map((e) {
            final selected = especialidad == e;
            return ChoiceChip(
              label: Text(e.label),
              selected: selected,
              onSelected: (_) => onSelect(e),
              selectedColor: AppColors.ink,
              backgroundColor: theme.brightness == Brightness.dark
                  ? AppColors.darkElevated
                  : AppColors.mist,
              side: BorderSide(
                color: selected
                    ? AppColors.ink
                    : (theme.brightness == Brightness.dark
                        ? AppColors.darkStroke
                        : AppColors.stroke),
              ),
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                color: selected
                    ? AppColors.white
                    : (theme.brightness == Brightness.dark
                        ? AppColors.darkText
                        : AppColors.textPrimary),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _StepExamDate extends StatelessWidget {
  const _StepExamDate({
    super.key,
    required this.examDate,
    required this.onPick,
  });

  final DateTime? examDate;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: [
        Text('¿Cuándo es tu examen? (opcional)', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Usamos la fecha para armar un plan diario realista hasta la convocatoria.',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.calendar_month_outlined),
          label: Text(
            examDate == null
                ? 'Elegir fecha'
                : '${examDate!.day}/${examDate!.month}/${examDate!.year}',
          ),
        ),
      ],
    );
  }
}

class _SelectTile extends StatelessWidget {
  const _SelectTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: selected
          ? AppColors.canopy.withValues(alpha: 0.12)
          : theme.cardTheme.color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.canopy : theme.colorScheme.outline,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Text(title, style: theme.textTheme.titleSmall)),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? AppColors.canopy : theme.colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

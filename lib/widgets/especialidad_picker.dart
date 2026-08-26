import 'package:flutter/material.dart';

import '../models/enums.dart';
import '../theme/app_colors.dart';

/// Las 7 de portada a la vista; el resto solo si se busca.
class EspecialidadPicker extends StatefulWidget {
  const EspecialidadPicker({
    super.key,
    this.cargo,
    required this.especialidad,
    required this.onSelect,
  });

  final CargoAspiracion? cargo;
  final Especialidad? especialidad;
  final ValueChanged<Especialidad> onSelect;

  @override
  State<EspecialidadPicker> createState() => _EspecialidadPickerState();
}

class _EspecialidadPickerState extends State<EspecialidadPicker> {
  final _busqueda = TextEditingController();

  @override
  void dispose() {
    _busqueda.dispose();
    super.dispose();
  }

  List<Especialidad> _visibles({
    required bool esDirectivo,
    required bool buscando,
    required String query,
  }) {
    if (esDirectivo) return const [Especialidad.directivos];
    if (buscando) {
      return Especialidad.buscar(query, cargo: widget.cargo);
    }
    final seleccion = widget.especialidad;
    if (seleccion != null && !Especialidad.portada.contains(seleccion)) {
      return [seleccion, ...Especialidad.portada];
    }
    return Especialidad.portada;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cargo = widget.cargo;
    final esDirectivo = cargo?.esGestionInstitucional == true;
    final query = _busqueda.text.trim();
    final buscando = query.isNotEmpty;
    final visibles = _visibles(
      esDirectivo: esDirectivo,
      buscando: buscando,
      query: query,
    );

    return ListView(
      children: [
        Text(
          '¿Cuál es tu especialidad o nivel?',
          style: theme.textTheme.titleMedium,
        ),
        if (esDirectivo) ...[
          const SizedBox(height: 8),
          Text(
            'Para Directivo calibramos Gestión directiva: PEI, gobierno '
            'escolar, SIEE y convivencia.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: 16),
        if (visibles.isEmpty)
          Text(
            'Ninguna especialidad coincide. Prueba con el área o el nivel.',
            style: theme.textTheme.bodyMedium,
          )
        else
          _ChipWrap(
            opciones: visibles,
            selected: widget.especialidad,
            onSelect: (v) {
              _busqueda.clear();
              widget.onSelect(v);
            },
          ),
        if (!esDirectivo) ...[
          const SizedBox(height: 22),
          Text('¿No ves tu área?', style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          TextField(
            controller: _busqueda,
            onChanged: (_) => setState(() {}),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Inglés, artística, física…',
              suffixIcon: buscando
                  ? IconButton(
                      tooltip: 'Limpiar búsqueda',
                      onPressed: () {
                        _busqueda.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
            ),
          ),
        ],
      ],
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({
    required this.opciones,
    required this.selected,
    required this.onSelect,
  });

  final List<Especialidad> opciones;
  final Especialidad? selected;
  final ValueChanged<Especialidad> onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final e in opciones)
          ChoiceChip(
            label: Text(e.label),
            selected: selected == e,
            onSelected: (_) => onSelect(e),
            selectedColor: AppColors.ink,
            backgroundColor: isDark ? AppColors.darkElevated : AppColors.mist,
            side: BorderSide(
              color: selected == e
                  ? AppColors.ink
                  : (isDark ? AppColors.darkStroke : AppColors.stroke),
            ),
            labelStyle: theme.textTheme.labelLarge?.copyWith(
              color: selected == e
                  ? AppColors.white
                  : (isDark ? AppColors.darkText : AppColors.textPrimary),
            ),
          ),
      ],
    );
  }
}

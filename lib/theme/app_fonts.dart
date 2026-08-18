import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_typography.dart';

/// Carga Fraunces y Plus Jakarta desde assets (sin fetch HTTP).
/// Evita el salto de tipografía (FOUT) en la landing.
Future<void> prepareAppFonts() async {
  try {
    GoogleFonts.config.allowRuntimeFetching = false;
    LicenseRegistry.addLicense(() async* {
      final fraunces =
          await rootBundle.loadString('google_fonts/Fraunces-OFL.txt');
      yield LicenseEntryWithLineBreaks(const ['google_fonts'], fraunces);
      final jakarta =
          await rootBundle.loadString('google_fonts/PlusJakartaSans-OFL.txt');
      yield LicenseEntryWithLineBreaks(const ['google_fonts'], jakarta);
    });
    AppTypography.lightTextTheme();
    // Tope de espera: en web las fuentes viajan por HTTP y con red lenta
    // retrasaban el primer cuadro (pantalla en blanco tras el splash).
    // Si no llegan a tiempo, se pinta con la fuente de respaldo y Flutter
    // repinta al terminar la descarga.
    await GoogleFonts.pendingFonts().timeout(
      const Duration(milliseconds: 1200),
      onTimeout: () {
        debugPrint('prepareAppFonts: espera agotada, se pinta sin bloquear.');
        return const <void>[];
      },
    );
  } catch (e) {
    debugPrint('prepareAppFonts: $e');
    GoogleFonts.config.allowRuntimeFetching = true;
  }
}

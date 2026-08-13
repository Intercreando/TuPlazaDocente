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
    await GoogleFonts.pendingFonts();
  } catch (e) {
    debugPrint('prepareAppFonts: $e');
    GoogleFonts.config.allowRuntimeFetching = true;
  }
}

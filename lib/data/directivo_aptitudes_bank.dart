import '../models/question.dart';
import 'directivo_aptitudes_lectura_bank.dart';
import 'directivo_aptitudes_lectura_ola2_bank.dart';
import 'directivo_aptitudes_numerica_bank.dart';
import 'directivo_aptitudes_numerica_ola2_bank.dart';
import 'directivo_aptitudes_blandas_bank.dart';
import 'directivo_aptitudes_blandas_ola2_bank.dart';
import 'directivo_aptitudes_gestion_bank.dart';
import 'directivo_aptitudes_gestion_ola2_bank.dart';
import 'directivo_aptitudes_pedagogicas_bank.dart';
import 'directivo_aptitudes_pedagogicas_ola2_bank.dart';

/// Banco Directivo Docente — Aptitudes y Competencias Básicas (olas 1 y 2).
abstract final class DirectivoAptitudesBank {
  static List<Question> get items => [
        ...DirectivoAptitudesLecturaBank.items,
        ...DirectivoAptitudesLecturaBankOla2.items,
        ...DirectivoAptitudesNumericaBank.items,
        ...DirectivoAptitudesNumericaBankOla2.items,
        ...DirectivoAptitudesBlandasBank.items,
        ...DirectivoAptitudesBlandasBankOla2.items,
        ...DirectivoAptitudesGestionBank.items,
        ...DirectivoAptitudesGestionBankOla2.items,
        ...DirectivoAptitudesPedagogicasBank.items,
        ...DirectivoAptitudesPedagogicasBankOla2.items,
      ];
}

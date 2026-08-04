import '../models/question.dart';
import 'directivo_aptitudes_lectura_bank.dart';
import 'directivo_aptitudes_lectura_ola2_bank.dart';
import 'directivo_aptitudes_lectura_ola3_bank.dart';
import 'directivo_aptitudes_lectura_ola4_bank.dart';
import 'directivo_aptitudes_numerica_bank.dart';
import 'directivo_aptitudes_numerica_ola2_bank.dart';
import 'directivo_aptitudes_numerica_ola3_bank.dart';
import 'directivo_aptitudes_numerica_ola4_bank.dart';
import 'directivo_aptitudes_blandas_bank.dart';
import 'directivo_aptitudes_blandas_ola2_bank.dart';
import 'directivo_aptitudes_blandas_ola3_bank.dart';
import 'directivo_aptitudes_blandas_ola4_bank.dart';
import 'directivo_aptitudes_gestion_bank.dart';
import 'directivo_aptitudes_gestion_ola2_bank.dart';
import 'directivo_aptitudes_disciplinares_ola3_bank.dart';
import 'directivo_aptitudes_disciplinares_ola4_bank.dart';
import 'directivo_aptitudes_pedagogicas_bank.dart';
import 'directivo_aptitudes_pedagogicas_ola2_bank.dart';
import 'directivo_aptitudes_pedagogicas_ola3_bank.dart';
import 'directivo_aptitudes_pedagogicas_ola4_bank.dart';

/// Banco Directivo Docente — Aptitudes y Competencias Básicas (olas 1–4).
abstract final class DirectivoAptitudesBank {
  static List<Question> get items => [
        ...DirectivoAptitudesLecturaBank.items,
        ...DirectivoAptitudesLecturaBankOla2.items,
        ...DirectivoAptitudesLecturaBankOla3.items,
        ...DirectivoAptitudesLecturaBankOla4.items,
        ...DirectivoAptitudesNumericaBank.items,
        ...DirectivoAptitudesNumericaBankOla2.items,
        ...DirectivoAptitudesNumericaBankOla3.items,
        ...DirectivoAptitudesNumericaBankOla4.items,
        ...DirectivoAptitudesBlandasBank.items,
        ...DirectivoAptitudesBlandasBankOla2.items,
        ...DirectivoAptitudesBlandasBankOla3.items,
        ...DirectivoAptitudesBlandasBankOla4.items,
        ...DirectivoAptitudesGestionBank.items,
        ...DirectivoAptitudesGestionBankOla2.items,
        ...DirectivoAptitudesDisciplinaresBankOla3.items,
        ...DirectivoAptitudesDisciplinaresBankOla4.items,
        ...DirectivoAptitudesPedagogicasBank.items,
        ...DirectivoAptitudesPedagogicasBankOla2.items,
        ...DirectivoAptitudesPedagogicasBankOla3.items,
        ...DirectivoAptitudesPedagogicasBankOla4.items,
      ];
}

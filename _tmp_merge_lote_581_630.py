# -*- coding: utf-8 -*-
"""Ajustes de voz, typos, des-duplicado y parche de questions_v1.json (581-630)."""
import json
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(r"c:\Users\MSI\Documents\Proyectos\TuPlazaDocente")

VOICE = {
    "fs-com-22": [
        "Intervenir con calma, pedir a los colegas que desescalen el tono y convocarlos a un espacio institucional sin estudiantes, para que coordinación medie el desacuerdo con reserva y registro, y el grupo no quede como público del conflicto laboral.",
        "Facilitar un círculo restaurativo en el mismo salón, con el grupo como testigo de los acuerdos, para modelar la Ley 1620 y cerrar el incidente en caliente, sin retirar a los estudiantes del escenario del desacuerdo entre adultos.",
        "Solicitar a rectoría el inicio inmediato de investigación disciplinaria a ambos docentes, con informe al Comité de Convivencia, para sentar precedente de que el aula no es foro de rencillas y el clima quede ejemplarizado ante la comunidad.",
        "Pedir al personero estudiantil que medie entre los docentes frente al grupo, para fortalecer el gobierno escolar y dar voz a los estudiantes, y dejar el conducto de coordinación y reserva para un momento posterior de la jornada.",
    ],
    "fs-com-23": [
        "En la misma reunión acordar modificar la valoración del período para calmar al acudiente, dejar constancia de buena disposición y citar otra fecha cuando bajen los ánimos, sin reabrir evidencias del SIEE ni la ruta de reclamación prevista.",
        "Orientar al acudiente a tutelar o a radicar de inmediato en Personería y Secretaría de Educación, como primera instancia, para que el control externo revise la nota antes de agotar el SIEE, el docente y el Consejo Académico.",
        "Escuchar el reclamo con respeto, explicar los criterios públicos del SIEE con evidencias del proceso del estudiante y ofrecer la ruta institucional de aclaración y reclamación, sin alterar la nota en el momento de la visita del acudiente.",
        "Levantar un compromiso verbal de revisar la nota en cuanto se pueda, sin fecha, sin responsable y sin evidencias del SIEE, para que la familia sienta atención inmediata y se retire del colegio ese mismo día con una sensación de avance.",
    ],
    "fs-com-24": [
        "Enviar al interesado un resumen del proceso interno por WhatsApp, con nombres y estado, argumentando agilidad y confianza interpersonal, y pedirle que no lo radique para evitar el trámite de archivo, reserva y habeas data.",
        "Negarte con respeto a revelar datos del proceso interno, explicar reserva, Ley 1581 y deber de confidencialidad, y orientar a radicar la solicitud por el conducto institucional para que el responsable del archivo resuelva con reserva.",
        "Entregar de inmediato copia del expediente invocando la Ley 1712 de transparencia, sin consultar clasificación de reserva ni autorización de rectoría, para demostrar apertura institucional y evitar un roce con quien pregunta por el proceso.",
        "Acordar un informe verbal en el pasillo esa misma tarde, sin fecha de entrega formal ni responsable de archivo, para no burocratizar el pedido y mantener la relación con quien consulta el proceso interno del colegio.",
    ],
    "fs-com-25": [
        "Imprimir el PEI vigente y fijarlo en portería y carteleras de acceso para que la comunidad lo vea, y reportar cumplimiento formal ante la visita, sin jornadas internas de sentido ni rutinas de aula acordadas con el equipo docente.",
        "Expedir un memo de coordinación que ordene alinear los planeadores al PEI en ocho días, sin diagnóstico de brechas ni deliberación de áreas, para dejar rastro de liderazgo visible en la carpeta de calidad y en el cronograma de la visita.",
        "Diagnosticar con el equipo las brechas de apropiación del PEI, socializar su sentido pedagógico en el gobierno escolar y acordar rutinas de aula, responsables y seguimiento, para que el horizonte institucional oriente la práctica cotidiana.",
        "Llevar el PEI al Consejo Directivo para que se readopte en un acta con firmas y sello, y dar por resuelta la baja apropiación, sin caracterizar brechas del equipo ni acordar rutinas pedagógicas de aula y de seguimiento.",
    ],
    "fs-com-26": [
        "Trasladar el desacuerdo de criterios al Comité Escolar de Convivencia para que, como tribunal, decida qué enfoque debe prevalecer en el área, cubriendo un conflicto curricular con la ruta de atención de la Ley 1620 de 2013.",
        "Radicar el desacuerdo de criterios en Secretaría de Educación como primer paso, para que el nivel territorial zanje el enfoque del área antes de agotar el Consejo Académico, el SIEE y los acuerdos pedagógicos del PEI institucional.",
        "Facilitar que el área coteje evidencias de aprendizaje, el SIEE y los acuerdos del PEI, y deje en acta criterios comunes, responsables y fecha de revisión, de modo que el desacuerdo se resuelva con norma institucional y no con imposiciones.",
        "Proponer que el jefe de área fije el criterio sin contrastar evidencias, para cumplir el cronograma de mallas y dejar la decisión en un acta de asistencia, y el resto del equipo se limite a firmar de enterado al cierre de la reunión.",
    ],
    "fs-com-27": [
        "Intervenir con calma en el pasillo, detener el intercambio frente a terceros y convocar a las partes a un espacio institucional reservado, con mediación de coordinación y registro, para que el conflicto público no se vuelva espectáculo escolar.",
        "Invitar a un círculo restaurativo ahí mismo, con quienes transitan el pasillo como testigos del acuerdo, para modelar ciudadanía de la Ley 1620 y enfriar el incidente sin retirar a estudiantes ni acudientes del lugar de circulación pública.",
        "Pedir a rectoría levantar de inmediato proceso disciplinario a quien alzó la voz, para sentar precedente de respeto en zonas comunes, y dejar la mediación del caso concreto para cuando el expediente disciplinario haya avanzado en rectoría.",
        "Aplazar el incidente y lanzar esa semana una encuesta anónima de clima a docentes y familias, para diagnosticar el ambiente general del colegio, en lugar de mediar el conflicto concreto que está ocurriendo entre las partes en el pasillo.",
    ],
    "fs-com-28": [
        "Atender al acudiente con escucha activa, mostrar evidencias y criterios del SIEE del período e indicar la ruta de aclaración —docente, coordinación y Consejo Académico—, sin modificar la valoración en el momento del reclamo de la familia.",
        "Revisar el boletín y, para calmar a la familia, acordar ajustar la valoración del período en esa misma reunión, con el argumento de que la escucha debe traducirse en un gesto concreto en el sistema de notas y en el boletín escolar.",
        "Entregar al acudiente, en un espacio de circulación, copia del observador y de planillas de varios estudiantes para que compare y verifique equidad, y así la familia compruebe que no hubo privilegios en la valoración del período.",
        "Convocar al Comité Escolar de Convivencia para que revise si la nota fue justa, como si se tratara de una situación de clima, y desplazar al SIEE y al Consejo Académico en un asunto de evaluación de aprendizajes del período.",
    ],
    "fs-com-29": [
        "Negarte con respeto a entregar información reservada del proceso interno, citar la Ley 1581 y el deber de confidencialidad, y orientar al solicitante al conducto regular de archivo y reserva que define la rectoría de la institución educativa.",
        "Entregar al concejal un informe extraoficial con extractos y nombres del proceso, argumentando apoyo al control político local, y pedirle que no lo radique para evitar un trámite de transparencia, reserva y archivo institucional.",
        "Subir el expediente a una carpeta compartida con enlace abierto para facilitar la consulta y avisar al interesado por chat, sin clasificación de reserva ni autorización del archivo institucional que custodia el proceso interno.",
        "Autorizar una nota en la red del colegio que resume el proceso interno para que no circule el rumor, con el argumento de transparencia preventiva, sin reserva de datos ni el conducto de comunicaciones oficiales de rectoría.",
    ],
    "fs-com-30": [
        "Enviar el PDF del PEI por el grupo masivo de WhatsApp de acudientes y dejarlo en portería para que se vea, y considerar resuelta la baja apropiación del equipo, sin jornadas internas de sentido ni rutinas de seguimiento en el aula.",
        "Firmar una circular de rectoría que ordene alinear todas las áreas al PEI en la siguiente semana, sin diagnóstico de brechas ni deliberación colegiada, para dejar constancia de liderazgo directivo ante la visita de calidad y el archivo de gestión.",
        "Como directivo, caracterizar las brechas de apropiación del PEI con el Consejo Académico, socializar el horizonte en jornadas de equipo y acordar rutinas de seguimiento en aula y actas, para que el proyecto deje de ser un documento de archivo.",
        "Abrir investigación disciplinaria a quienes no citan el PEI en sus planeadores, para sentar precedente de apropiación institucional, y dejar el trabajo de sentido y de rutinas de aula para un taller posterior que aún no tiene fecha ni responsable.",
    ],
    "fs-com-31": [
        "Pedir que el Comité Escolar de Convivencia arbitre el desacuerdo de rúbricas como si fuera una situación Tipo II, para que una instancia de clima escolar zanje un conflicto curricular y el área salga unificada al término de la reunión.",
        "Solicitar a coordinación un memo que imponga el criterio de un subgrupo sin deliberación del área, para salir a tiempo y dejar unidad de criterio en la carpeta de calidad, sin contraste con DBA, SIEE ni acuerdos vigentes del PEI.",
        "Moderar la reunión para que el área contraste evidencias, DBA y SIEE, construya acuerdos escritos de criterio, responsables y fecha de seguimiento, y eleve al Consejo Académico lo que exceda al equipo, con respeto al gobierno escolar.",
        "Cerrar con un apretón de manos y el compromiso de alinearse en el espíritu del área, sin fecha ni responsable, para no tensionar al equipo y dejar que cada aula conserve, en la práctica, su propio criterio de valoración.",
    ],
}


def patch_text_fields(item):
    for field in ("explanation", "normativeJustification", "theoreticalJustification"):
        val = item.get(field)
        if isinstance(val, str):
            item[field] = val.replace("reconducce", "reconduce")


def main():
    path_601 = ROOT / "_tmp_out_601_610.json"
    items_601 = json.loads(path_601.read_text(encoding="utf-8"))
    for it in items_601:
        it["options"] = VOICE[it["id"]]
        patch_text_fields(it)
    path_601.write_text(json.dumps(items_601, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    path_611 = ROOT / "_tmp_out_611_620.json"
    items_611 = json.loads(path_611.read_text(encoding="utf-8"))
    for it in items_611:
        patch_text_fields(it)
        if it["id"] == "fs-com-35":
            it["options"][3] = (
                "Mapear con el Consejo Académico dónde el PEI aún no orienta la planeación, "
                "devolver su horizonte al equipo y pactar rutinas de uso en aula, actas y "
                "seguimiento, con responsables y fechas de verificación."
            )
    path_611.write_text(json.dumps(items_611, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    r = subprocess.run([sys.executable, str(ROOT / "_tmp_validate_lote_581_630.py")], cwd=ROOT)
    if r.returncode != 0:
        raise SystemExit("validator failed")

    chunks = [(581, 590), (591, 600), (601, 610), (611, 620), (621, 630)]
    patch_keys = [
        "options",
        "explanation",
        "normativeJustification",
        "theoreticalJustification",
        "distractorAnalysis",
    ]
    upgrades = {}
    for start, end in chunks:
        for it in json.loads((ROOT / f"_tmp_out_{start}_{end}.json").read_text(encoding="utf-8")):
            upgrades[it["id"]] = it

    seed_path = ROOT / "assets" / "seed" / "questions_v1.json"
    data = json.loads(seed_path.read_text(encoding="utf-8"))
    lote = data["items"][580:630]
    assert len(lote) == 50

    touched = []
    for src in lote:
        dst_item = upgrades[src["id"]]
        frozen = {
            "correctIndex": src["correctIndex"],
            "difficulty": src["difficulty"],
            "dificultad": src.get("dificultad"),
            "caseContext": src.get("caseContext"),
            "stem": src.get("stem"),
        }
        for k in patch_keys:
            src[k] = dst_item[k]
        assert src["correctIndex"] == frozen["correctIndex"]
        assert src["difficulty"] == frozen["difficulty"]
        assert src.get("dificultad") == frozen["dificultad"]
        assert src.get("caseContext") == frozen["caseContext"]
        assert src.get("stem") == frozen["stem"]
        src["qualityHardened"] = True
        touched.append(src["id"])

    data["contestUpgradeWave8"] = {
        "at": datetime.now(timezone.utc).isoformat(),
        "itemsTouched": 50,
        "range": "581-630",
        "note": "reglas_cnsc.md: options/explanation/justifications/distractorAnalysis",
    }
    seed_path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print("patched", len(touched))
    print(",".join(touched))


if __name__ == "__main__":
    main()

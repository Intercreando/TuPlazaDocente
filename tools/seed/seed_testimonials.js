/**
 * Siembra 4 opiniones iniciales (feedback temprano, approved=true).
 *
 *   cd tools/seed
 *   node seed_testimonials.js
 */
const path = require("path");
const admin = require("firebase-admin");

const PROJECT_ID = "tuplazadocente-9334d";
const SA_PATH = path.join(__dirname, "serviceAccount.json");

const SEEDS = [
  {
    id: "seed-1",
    displayName: "Carolina R.",
    roleLabel: "Docente · Primaria",
    text:
      "Lo que más me sirve es la explicación después de cada ítem: no solo me dice " +
      "si fallé, sino el criterio. Así dejo de memorizar a ciegas.",
  },
  {
    id: "seed-2",
    displayName: "Andrés M.",
    roleLabel: "Aspirante a rector",
    text:
      "Entreno 10 minutos en la noche con la racha. El plan diario me ordena qué " +
      "tocar cuando el tiempo aprieta cerca de la convocatoria.",
  },
  {
    id: "seed-3",
    displayName: "Juliana P.",
    roleLabel: "Ciencias naturales",
    text:
      "Los casos de aula se sienten cercanos al colegio. Me ayuda a pensar el " +
      "debido proceso, no solo la respuesta “bonita”.",
  },
  {
    id: "seed-4",
    displayName: "Diego H.",
    roleLabel: "Educación física",
    text:
      "Empecé en gratis y se nota qué está limitado. Cuando pasé a Premium pude " +
      "practicar especialidad sin pelearme con los cupos del día.",
  },
];

function initAdmin() {
  if (admin.apps.length) return;
  if (require("fs").existsSync(SA_PATH)) {
    // eslint-disable-next-line import/no-dynamic-require, global-require
    const sa = require(SA_PATH);
    admin.initializeApp({
      credential: admin.credential.cert(sa),
      projectId: PROJECT_ID,
    });
    return;
  }
  admin.initializeApp({projectId: PROJECT_ID});
}

async function main() {
  initAdmin();
  const db = admin.firestore();
  for (const seed of SEEDS) {
    await db.collection("testimonials").doc(seed.id).set(
        {
          text: seed.text,
          displayName: seed.displayName,
          roleLabel: seed.roleLabel,
          source: "seed",
          approved: true,
          uid: null,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        },
        {merge: true},
    );
    console.log(`OK seed: ${seed.id}`);
  }
  console.log(
      "Listo. Para publicar opiniones de usuarios: en Firestore pon approved=true.",
  );
}

main().catch((err) => {
  console.error(err.message || err);
  process.exit(1);
});

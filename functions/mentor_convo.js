/**
 * Mentor IA conversacional: prueba 1 sesión / pase 4 al día, 8 turnos.
 * El cliente no escribe las sesiones: solo Admin SDK.
 */
const {onCall, HttpsError} = require("firebase-functions/v2/https");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const {generateText} = require("./lib/gemini_vertex");
const core = require("./lib/mentor_convo_core");

const CALL_OPTS = {
  region: "southamerica-east1",
  timeoutSeconds: 45,
  memory: "256MiB",
  minInstances: 0,
  maxInstances: 8,
};

/**
 * @return {string}
 */
function bogotaDay() {
  return new Intl.DateTimeFormat("en-CA", {
    timeZone: "America/Bogota",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).format(new Date());
}

/**
 * @param {object} request
 * @return {{uid: string}}
 */
function requirePremiumAccount(request) {
  if (!request.auth?.uid) {
    throw new HttpsError(
        "unauthenticated",
        "Inicia sesión para hablar con el mentor.",
    );
  }
  const provider = request.auth.token?.firebase?.sign_in_provider;
  if (provider === "anonymous") {
    throw new HttpsError(
        "permission-denied",
        "Crea una cuenta (Google o correo) para el mentor.",
    );
  }
  return {uid: request.auth.uid};
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @param {string} kind
 * @return {Promise<{day: string}>}
 */
async function reserveStart(db, uid, kind) {
  const day = bogotaDay();
  const userRef = db.doc(`users/${uid}`);
  const usageRef = db.doc(`users/${uid}/usage/mentorConvo`);
  await db.runTransaction(async (tx) => {
    const userSnap = await tx.get(userRef);
    const userData = userSnap.data() || {};
    const access = core.resolveAccess(userData);
    if (!access.ok) {
      if (access.code === "paywall") {
        throw new HttpsError(
            "failed-precondition",
            "Tu sesión de prueba ya se usó. Activa el pase de 30 días " +
            "para 4 tutorías guiadas al día.",
            {paywall: true},
        );
      }
      throw new HttpsError(
          "permission-denied",
          "El mentor conversacional es para cuentas Premium.",
      );
    }
    if (access.kind !== kind) {
      throw new HttpsError(
          "aborted",
          "El acceso al mentor cambió. Vuelve a intentarlo.",
      );
    }
    if (kind === "trial") {
      if (userData.mentorTrialUsed === true) {
        throw new HttpsError(
            "failed-precondition",
            "Tu sesión de prueba ya se usó. Activa el pase de 30 días.",
            {paywall: true},
        );
      }
      tx.set(userRef, {
        mentorTrialUsed: true,
        mentorTrialUsedAt: FieldValue.serverTimestamp(),
      }, {merge: true});
    } else {
      const usageSnap = await tx.get(usageRef);
      const usage = usageSnap.exists ? usageSnap.data() : {};
      const count = usage.day === day ? Number(usage.count || 0) : 0;
      if (count >= core.DAILY_SESSIONS) {
        throw new HttpsError(
            "resource-exhausted",
            `Ya usaste las ${core.DAILY_SESSIONS} tutorías del día. Vuelven mañana.`,
        );
      }
      tx.set(usageRef, {
        day,
        count: count + 1,
        updatedAt: FieldValue.serverTimestamp(),
      }, {merge: true});
    }
  });
  return {day};
}

/**
 * Devuelve el cupo diario del pase solo si Vertex no llegó a llamarse.
 * La prueba de por vida no se revierte (anti doble inicio).
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} uid
 * @param {string} day
 * @param {string} kind
 * @return {Promise<void>}
 */
async function releasePassSession(db, uid, day, kind) {
  if (kind !== "pass") return;
  const usageRef = db.doc(`users/${uid}/usage/mentorConvo`);
  try {
    await db.runTransaction(async (tx) => {
      const snap = await tx.get(usageRef);
      if (!snap.exists) return;
      const data = snap.data() || {};
      if (data.day !== day) return;
      const count = Math.max(0, Number(data.count || 0) - 1);
      tx.set(usageRef, {
        day,
        count,
        updatedAt: FieldValue.serverTimestamp(),
      }, {merge: true});
    });
  } catch (err) {
    console.error("mentor_convo releasePassSession", err);
  }
}

/**
 * @param {FirebaseFirestore.Firestore} db
 * @param {string} day
 * @param {boolean} isStart
 * @return {Promise<void>}
 */
async function reserveGlobal(db, day, isStart) {
  const ref = db.doc("mentorConvoMeta/daily");
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    const data = snap.exists ? snap.data() : {};
    const sameDay = data.day === day;
    const starts = sameDay ? Number(data.starts || 0) : 0;
    const calls = sameDay ? Number(data.geminiCalls || 0) : 0;
    if (isStart && starts >= core.GLOBAL_START_CAP) {
      throw new HttpsError(
          "resource-exhausted",
          "El mentor llegó al tope de sesiones del día. Vuelve mañana.",
      );
    }
    if (calls >= core.GLOBAL_GEMINI_CAP) {
      throw new HttpsError(
          "resource-exhausted",
          "El mentor llegó al tope del día. Vuelve mañana.",
      );
    }
    tx.set(ref, {
      day,
      starts: isStart ? starts + 1 : starts,
      geminiCalls: calls + 1,
      updatedAt: FieldValue.serverTimestamp(),
    });
  });
}

/**
 * @param {unknown} raw
 * @param {number} min
 * @return {string}
 */
function requireClip(raw, min) {
  const text = core.clipText(raw, 4000);
  if (text.length < min) {
    throw new HttpsError("invalid-argument", "Faltan datos del caso.");
  }
  return text;
}

/**
 * @param {string} systemPrompt
 * @param {string} userPrompt
 * @param {object[]=} contents
 * @return {Promise<string>}
 */
async function callMentor(systemPrompt, userPrompt, contents) {
  const text = await generateText(systemPrompt, userPrompt, {
    maxOutputTokens: core.MAX_OUTPUT_TOKENS,
    maxWords: core.MAX_WORDS,
    contents,
  });
  if (!text || text.split(/\s+/).length < 8) {
    console.error("mentor_convo texto corto (cupo conservado)");
    throw new HttpsError(
        "unavailable",
        "El mentor no pudo responder. Intenta de nuevo en un momento.",
    );
  }
  return text;
}

exports.startMentorSession = onCall(CALL_OPTS, async (request) => {
  const {uid} = requirePremiumAccount(request);
  const db = getFirestore();
  const userSnap = await db.doc(`users/${uid}`).get();
  const access = core.resolveAccess(userSnap.data() || {});
  if (!access.ok) {
    if (access.code === "paywall") {
      throw new HttpsError(
          "failed-precondition",
          "Tu sesión de prueba ya se usó. Activa el pase de 30 días " +
          "para 4 tutorías guiadas al día.",
          {paywall: true},
      );
    }
    throw new HttpsError(
        "permission-denied",
        "El mentor conversacional es para cuentas Premium.",
    );
  }

  const data = request.data || {};
  const questionId = core.clipText(data.questionId, 80);
  const chosenIndex = Number(data.chosenIndex);
  if (!questionId || !Number.isInteger(chosenIndex) || chosenIndex < 0) {
    throw new HttpsError("invalid-argument", "Falta el caso o la postura.");
  }
  const stemClip = requireClip(data.stem, 12);
  const caseClip = core.clipText(data.caseContext, 4000);
  const correctClip = requireClip(data.correctOption, 4);
  const chosenClip = requireClip(data.chosenOption, 4);

  const day = bogotaDay();
  await reserveStart(db, uid, access.kind);
  try {
    await reserveGlobal(db, day, true);
  } catch (err) {
    await releasePassSession(db, uid, day, access.kind);
    throw err;
  }

  const sessionSeed = {
    stemClip,
    caseClip,
    correctClip,
    chosenClip,
    stanceSummary: core.stanceSummaryFrom(chosenClip, ""),
  };
  const systemPrompt = core.buildSystemPrompt(sessionSeed);

  try {
    const text = await callMentor(systemPrompt, core.buildOpeningPrompt());
    const sessionRef = db.collection(`users/${uid}/tutorSessions`).doc();
    const closed = core.nextTurnState(1, access.kind);
    await sessionRef.set({
      questionId,
      chosenIndex,
      kind: access.kind,
      status: closed.status,
      turnCount: 1,
      vertexCalls: 1,
      stemClip,
      caseClip,
      correctClip,
      chosenClip,
      stanceSummary: sessionSeed.stanceSummary,
      lastUserClip: "",
      lastMentorClip: core.clipText(text, 700),
      createdAt: FieldValue.serverTimestamp(),
      closedAt: closed.status === "closed" ? FieldValue.serverTimestamp() : null,
      closeReason: closed.closeReason,
    });
    return {
      sessionId: sessionRef.id,
      text,
      turnCount: 1,
      turnsLeft: core.MAX_TURNS - 1,
      status: closed.status,
      closeReason: closed.closeReason,
      paywall: closed.paywall,
      kind: access.kind,
    };
  } catch (err) {
    // Tras Vertex no se devuelve el cupo: un 200 vacío o un 429 ya se pudo cobrar.
    if (err instanceof HttpsError || err?.httpErrorCode) throw err;
    console.error("mentor_convo start", err);
    throw new HttpsError(
        "unavailable",
        "No pudimos abrir el mentor. Intenta de nuevo en un momento.",
    );
  }
});

exports.mentorConvoTurn = onCall(CALL_OPTS, async (request) => {
  const {uid} = requirePremiumAccount(request);
  const db = getFirestore();
  const data = request.data || {};
  const sessionId = core.clipText(data.sessionId, 80);
  const userText = core.clipUserInput(data.text);
  if (!sessionId) {
    throw new HttpsError("invalid-argument", "Falta la sesión.");
  }
  if (userText.length < 4) {
    throw new HttpsError(
        "invalid-argument",
        "Escribe una respuesta corta sobre el caso (mínimo unas palabras).",
    );
  }

  const sessionRef = db.doc(`users/${uid}/tutorSessions/${sessionId}`);
  const locked = await db.runTransaction(async (tx) => {
    const snap = await tx.get(sessionRef);
    if (!snap.exists) {
      throw new HttpsError("not-found", "Esa tutoría ya no está disponible.");
    }
    const session = snap.data() || {};
    const thinkingNow = session.status === "thinking";
    const stale = core.isThinkingStale(session);
    if (thinkingNow && !stale) {
      throw new HttpsError(
          "aborted",
          "El mentor está analizando tu postura. Espera un momento.",
      );
    }
    if (!thinkingNow && session.status !== "active") {
      throw new HttpsError(
          "failed-precondition",
          session.closeReason === "trial_done"
              ? "Tu sesión de prueba terminó. Activa el pase de 30 días."
              : "Esta tutoría ya se cerró.",
          {paywall: session.closeReason === "trial_done"},
      );
    }
    const turnCount = Number(session.turnCount || 0);
    if (turnCount >= core.MAX_TURNS) {
      throw new HttpsError(
          "resource-exhausted",
          "Esta sesión ya usó los 8 turnos.",
      );
    }
    const vertexCalls = Number(session.vertexCalls || turnCount || 0);
    if (!core.canAttemptVertex(vertexCalls)) {
      throw new HttpsError(
          "resource-exhausted",
          "Esta sesión ya usó los toques de Vertex. No se reintenta para no inflar la factura.",
      );
    }
    tx.set(sessionRef, {
      status: "thinking",
      vertexCalls: vertexCalls + 1,
      thinkingAt: FieldValue.serverTimestamp(),
    }, {merge: true});
    return {...session, vertexCalls};
  });

  const day = bogotaDay();
  const nextTurn = Number(locked.turnCount || 0) + 1;
  const vertexAfter = Number(locked.vertexCalls || 0) + 1;
  let vertexInvoked = false;
  try {
    await reserveGlobal(db, day, false);
    vertexInvoked = true;
    const systemPrompt = core.buildSystemPrompt(locked);
    const contents = core.slidingContents(
        locked.lastUserClip || "",
        locked.lastMentorClip || "",
        userText,
        nextTurn,
    );
    const text = await callMentor(systemPrompt, userText, contents);
    const closed = core.nextTurnState(nextTurn, locked.kind);
    const summary = core.stanceSummaryFrom(locked.chosenClip, userText);
    await sessionRef.set({
      status: closed.status,
      turnCount: nextTurn,
      vertexCalls: vertexAfter,
      lastUserClip: userText,
      lastMentorClip: core.clipText(text, 700),
      stanceSummary: summary,
      closedAt: closed.status === "closed" ? FieldValue.serverTimestamp() : null,
      closeReason: closed.closeReason,
      thinkingAt: FieldValue.delete(),
    }, {merge: true});
    return {
      sessionId,
      text,
      turnCount: nextTurn,
      turnsLeft: Math.max(0, core.MAX_TURNS - nextTurn),
      status: closed.status,
      closeReason: closed.closeReason,
      paywall: closed.paywall,
      kind: locked.kind,
    };
  } catch (err) {
    try {
      if (!vertexInvoked) {
        await sessionRef.set({
          status: "active",
          vertexCalls: Number(locked.vertexCalls || 0),
          thinkingAt: FieldValue.delete(),
        }, {merge: true});
      } else {
        // Vertex pudo cobrar. El toque se conserva; no hay reintento gratis.
        const exhausted = !core.canAttemptVertex(vertexAfter);
        await sessionRef.set({
          status: exhausted ? "closed" : "active",
          vertexCalls: vertexAfter,
          closeReason: exhausted ? "vertex_cap" : null,
          closedAt: exhausted ? FieldValue.serverTimestamp() : null,
          thinkingAt: FieldValue.delete(),
        }, {merge: true});
      }
    } catch (resetErr) {
      console.error("mentor_convo reset thinking", resetErr);
    }
    if (err instanceof HttpsError || err?.httpErrorCode) throw err;
    console.error("mentor_convo turn", err);
    throw new HttpsError(
        "unavailable",
        "No pudimos continuar la tutoría. Intenta de nuevo.",
    );
  }
});

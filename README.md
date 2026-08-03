# TuPlazaDocente

PWA (Progressive Web App) para entrenar el **Concurso Docente del Magisterio** (CNSC/ICFES): microlearning, feedback pedagógico, radar de competencias, racha diaria y simulacro con mapa de calor de tiempo.

Dominio: [www.tuplazadocente.com](https://www.tuplazadocente.com)

## Stack

- Flutter Web (PWA instalable)
- Firebase Hosting
- Persistencia local (`shared_preferences`) para perfil, racha y progreso

## Desarrollo

```bash
flutter pub get
flutter run -d chrome
```

## Build + deploy

```bash
flutter build web --release
firebase deploy --only hosting
```

## Flujos principales

1. Landing con **Instalar en el inicio**
2. Onboarding (cargo + especialidad + fecha)
3. Home con racha diaria y modos
4. **Plan diario** hasta la fecha de examen
5. **Casos de Aula** situacionales
6. Práctica con explicación inmediata
7. Examen real (2 min/pregunta) + mapa de calor
8. Radar de competencias
9. Freemium / Premium (Wompi)
10. Sync con Firebase Auth (anónimo / email / Google) + Firestore
11. Reto 60s de agilidad mental
12. Legales: `/legal/terms` y `/legal/privacy`

## Firebase (una vez)

1. Consola → Authentication → Sign-in method → activar:
   - **Anonymous**
   - **Email/Password**
   - **Google** (con tu OAuth client web)
2. En Authentication → Settings → Authorized domains: `www.tuplazadocente.com`, `tuplazadocente.com` y `tuplazadocente-9334d.web.app`
3. En Google Cloud → APIs y servicios → Credenciales → Cliente OAuth **Web**, añade URI de redirección:
   `https://www.tuplazadocente.com/__/auth/handler`
4. En el cliente, `authDomain` debe ser `www.tuplazadocente.com` (ver `lib/firebase_options.dart`)
5. En Hosting → Dominios personalizados: añade `www.tuplazadocente.com` como principal y redirige `tuplazadocente.com` → `www`
3. Firestore en `southamerica-east1` con rules de `users/{uid}`
4. Deploy:

```bash
flutter build web --release
firebase deploy --only hosting,firestore
```

## Wompi — pagos Premium (Colombia)

### Sandbox (pruebas)

1. Crea cuenta de comercio en [Wompi](https://comercios.wompi.co/) y obtén llaves de **pruebas**:
   - `pub_test_…`, `test_integrity_…`, `test_events_…`
2. Guarda los secretos en Firebase (nunca en el cliente):

```bash
firebase functions:secrets:set WOMPI_PUBLIC_KEY
firebase functions:secrets:set WOMPI_INTEGRITY_SECRET
firebase functions:secrets:set WOMPI_EVENTS_SECRET
```

3. Dashboard Wompi (**Sandbox**) → URL de eventos:

```text
https://southamerica-east1-tuplazadocente-9334d.cloudfunctions.net/wompiWebhook
```

4. Despliega functions y prueba en la app (tarjeta `4242…` / Nequi `3991111111`).

### Checklist — pasar a producción (cobros reales)

Usa esta lista **en orden**. No cobres a usuarios hasta marcar todos los puntos críticos.

- [ ] Comercio Wompi **aprobado** para producción (documentación / KYC al día).
- [ ] En Dashboard Wompi → **Producción**, copiar:
  - `pub_prod_…`
  - secreto de integridad de producción
  - secreto de eventos de producción
- [ ] Actualizar secrets en Firebase con los valores **prod** (mismos nombres de secret):

```bash
firebase functions:secrets:set WOMPI_PUBLIC_KEY
firebase functions:secrets:set WOMPI_INTEGRITY_SECRET
firebase functions:secrets:set WOMPI_EVENTS_SECRET
```

- [ ] Verificar que `WOMPI_PUBLIC_KEY` empieza por `pub_prod_` (no `pub_test_`).
- [ ] Redeploy functions para que lean los secrets nuevos:

```bash
firebase deploy --only functions
```

- [ ] En Dashboard Wompi → **Producción** → URL de eventos = la misma `…/wompiWebhook`.
- [ ] Pago real de prueba (monto bajo o el Premium) con cuenta real:
  - [ ] Wompi muestra APPROVED
  - [ ] En Firestore, `payments/{reference}` queda aprobado / coherente
  - [ ] `users/{uid}.isPremium == true`
  - [ ] Tras volver a `/premium`, la UI muestra Premium
- [ ] Revisar que Términos y Privacidad están publicados (`/legal/terms`, `/legal/privacy`) y enlazados en Auth + Premium.
- [ ] Definir correo de soporte real (hoy: `soporte@tuplazadocente.com` en `legal_documents.dart`) y que recibas ese buzón.
- [ ] Rotar o invalidar códigos Premium que hayan sido públicos; no volver a publicarlos en README.
- [ ] Soft launch: 2–5 pagos reales y revisar logs de `createPremiumCheckout` / `wompiWebhook` 24–48 h.

**Rollback rápido a sandbox:** vuelve a setear secrets `pub_test_` / `test_*` y redespliega functions.

Códigos Premium: viven solo en Cloud Function `activatePremiumCode` (no los publiques).

## Legales

- Términos: https://www.tuplazadocente.com/legal/terms
- Privacidad: https://www.tuplazadocente.com/legal/privacy
- Textos editables en `lib/config/legal_documents.dart`

## Recordatorios de racha

- Toggle en Home → pide permiso del navegador y muestra aviso local
- Cron Cloud Function `sendStreakReminders` (19:00 America/Bogota) envía FCM si el usuario tiene `fcmToken`

## Banco de preguntas (volumen / Firestore)

1. Generar / fusionar lotes (según el caso):

```bash
cd tools/seed
node generate_bank.js
# o merges específicos, p.ej.:
# node merge_directivo_aptitudes.js
# node merge_esp_ciencias_sociales.js
```

2. Validar sincronización (IDs únicos, lotes, Dart ↔ seed):

```bash
node tools/validate_bank_sync.js --dart
# Con Firestore (requiere serviceAccount.json):
node tools/validate_bank_sync.js --strict
```

3. Subir a Firestore (valida automáticamente antes de sembrar):

```bash
cd tools/seed
node seed_firestore.js
# o: npm run seed
```

`firebase deploy --only hosting` también corre `validate_bank_sync --dart` en predeploy.

La app carga el banco **asset-first** (seed embebido) y solo lee Firestore masivo si `meta/question_bank` indica versión/conteo más nuevo.
En Home verás la fuente `asset|firestore|local`.

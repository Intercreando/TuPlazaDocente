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
9. Freemium / Premium demo
10. Sync con Firebase Auth (anónimo / email / Google) + Firestore
11. Reto 60s de agilidad mental
12. Premium: Wompi (Colombia) · códigos · demo

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

1. Crea cuenta de comercio en [Wompi](https://comercios.wompi.co/) y obtén:
   - Llave pública (`pub_test_…` / `pub_prod_…`)
   - Secreto de integridad
   - Secreto de eventos (webhook)

2. Guarda los secretos en Firebase (nunca en el cliente):

```bash
firebase functions:secrets:set WOMPI_PUBLIC_KEY
firebase functions:secrets:set WOMPI_INTEGRITY_SECRET
firebase functions:secrets:set WOMPI_EVENTS_SECRET
```

3. En el Dashboard Wompi → URL de eventos (Sandbox y Producción por separado):

```text
https://southamerica-east1-tuplazadocente-9334d.cloudfunctions.net/wompiWebhook
```

4. Despliega functions:

```bash
cd functions && npm install && cd ..
firebase deploy --only functions
```

5. En la app: Premium → **Pagar una vez · Wompi** (requiere cuenta Google/correo)

Códigos Premium (servidor): `PLAZA2026`, `DOCENTE-REY`, `TUPLAZA-PREMIUM`, `DEMO-LOCAL`

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

La app carga en este orden: **Firestore → asset seed → bundle local**.
En Home verás `Banco: N ítems · fuente firestore|asset|local`.

# TuPlazaDocente

PWA (Progressive Web App) para entrenar el **Concurso Docente del Magisterio** (CNSC/ICFES): microlearning, feedback pedagógico, radar de competencias, racha diaria y simulacro con mapa de calor de tiempo.

Dominio: [TuPlazaDocente.com](https://tuplazadocente.com)

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
10. Sync opcional con Firebase Auth anónimo + Firestore

## Firebase (una vez)

1. Consola → Authentication → Sign-in method → activar **Anonymous**
2. Firestore ya creado en `southamerica-east1` con rules de `users/{uid}`
3. Deploy:

```bash
flutter build web --release
firebase deploy --only hosting,firestore
```

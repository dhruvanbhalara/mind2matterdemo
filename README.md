# Mind2Matter Mood Tracker Demo

Single-screen Flutter web mood tracker where users:
- log current mood (happy, neutral, sad),
- view recent 7 entries in a horizontal timeline,
- tap any timeline entry to trigger a short animation.

## Tech Notes
- Bundle id: `com.dhruvanbhalara.mind2matterdemo`
- Mood faces are drawn using `CustomPainter` (`drawCircle`, `drawArc`, `drawPath`)
- Localized UI strings are in `l10n/app_en.arb`
- Theme colors are centralized in `lib/app/theme/app_colors.dart`
- Clean architecture split:
  - `domain` (entities, repositories)
  - `application` (controller)
  - `infrastructure` (in-memory repository)
  - `presentation` (pages/widgets)

## Run
```bash
flutter pub get
flutter gen-l10n
flutter run -d chrome
```

## Test
```bash
flutter analyze
flutter test
```

## Build Web
```bash
flutter build web
```

## Deploy to Vercel
```bash
npx vercel deploy --prod
```

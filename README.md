# MyCollegeFinances

A Flutter application for comparing the real cost of college and modelling how
fees, scholarships, moratorium periods, and education loans affect long-term
repayment.

## What it does

- Manage multiple colleges and fee structures
- Break costs into tuition, hostel, exams, travel, laptop, and miscellaneous
- Apply fixed or percentage scholarships to selected years and semesters
- Compare simple and compound interest during a loan moratorium
- Model moratorium payments and semester-by-semester balances
- Review repayment projections, insights, and collection details
- Store planning data locally with `shared_preferences`

The calculations are planning aids, not financial advice. Confirm real loan and
scholarship terms with the relevant institution.

## Architecture

```text
lib/
├── data/services/       # local persistence
├── domain/
│   ├── logic/           # scholarship and loan calculations
│   ├── models/          # immutable domain models
│   └── providers/       # Riverpod application state
├── ui/
│   ├── screens/         # dashboard and planning flows
│   └── theme/           # application theme
├── main.dart
└── router.dart          # go_router routes
```

## Tech stack

- Flutter and Dart
- Riverpod for state management
- GoRouter for navigation
- Freezed and JSON serialization for domain models
- Shared Preferences for local persistence
- FL Chart for financial visualisation

## Run locally

Prerequisites: a current Flutter SDK and a configured Android, iOS, desktop, or
web target.

```bash
flutter pub get
flutter run
```

When domain models change, regenerate their supporting files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Quality checks

```bash
flutter analyze
flutter test
```

## Current scope

The application currently uses local persistence. Firebase packages are listed
for future authenticated sync, but the default flow does not require a Firebase
project.

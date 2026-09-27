# Contributing to MyCollegeFinances

Contributions that improve calculation correctness, accessibility, or planning clarity are welcome.

## Local checks

```bash
flutter pub get
flutter analyze
flutter test
```

Financial-logic changes belong in `lib/domain/logic/` and require unit tests covering boundary values, zero rates, partial scholarships, and moratorium behaviour. UI code should not duplicate domain calculations. Keep user data local unless an explicit, documented sync design is approved.

Pull requests must state the formula being changed and include a small worked example. The application provides planning estimates, not financial advice; avoid language that promises eligibility, savings, or repayment outcomes.

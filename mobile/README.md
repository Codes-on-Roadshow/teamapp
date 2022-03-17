# Team App Mobile

Mobile Application using Flutter

## Getting Started

### Install Dependencies
```
flutter pub get
```

### Running Application
1. Open Android emulator or IOS Simulator
2. Run flutter script
```
flutter run
```

## Behaviour Driven Development (BDD) Generator before develop feature file
```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```

## Integration Test
- Run your android emulator or IOS simulator
- Run integration test command
```
pushd mobile
flutter test integration_test/main_test.dart -r expanded
popd
```

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
```
firebase emulators:exec --import './integration_test/firebase_emulator' 'flutter test integration_test/main_test.dart'
```

## Running Firebase Emulator using Docker
```
docker run -p 9199:9199 -p 9099:9099 -p 9005:9005 -p 9000:9000 -p 8085:8085 -p 8080:8080 -p 5001:5001 -p 5000:5000 -p 4000:4000 -v $(pwd):/home/node --rm --name firebase-tools andreysenov/firebase-tools firebase emulators:start
```

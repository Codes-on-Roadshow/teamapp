import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teamapp/main.dart' as app;

Future<void> theAppIsRunning(WidgetTester tester) async {
  await app.main();
  await FirebaseAuth.instance.signOut();
  await tester.pumpAndSettle();
}

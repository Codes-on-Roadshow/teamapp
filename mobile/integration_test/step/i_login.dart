import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iLogin(WidgetTester tester) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: 'ranuwp@test.teamapp.com', password: 'ranuwp');
  await FirebaseAuth.instance.currentUser?.updateDisplayName("Ranu WP");
  await tester.pumpAndSettle();
}

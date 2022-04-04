import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:integration_test/integration_test.dart';
import 'profile_test.dart' as profile_test;
import 'team_test.dart' as team_test;
import 'authentication_test.dart' as authentication_test;

void main() async {
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  authentication_test.main();
  profile_test.main();
  team_test.main();
}
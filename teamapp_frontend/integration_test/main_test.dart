import 'package:integration_test/integration_test.dart';
import 'feature/profile/profile_test.dart' as profile_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  profile_test.main();
}
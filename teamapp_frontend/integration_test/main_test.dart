import 'package:integration_test/integration_test.dart';
import 'home_test.dart' as home_test;
import 'profile_test.dart' as profile_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  home_test.main();
  profile_test.main();
}
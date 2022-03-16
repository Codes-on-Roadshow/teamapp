import 'package:integration_test/integration_test.dart';
import 'profile_test.dart' as profile_test;
import 'team_test.dart' as team_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  profile_test.main();
  team_test.main();
}
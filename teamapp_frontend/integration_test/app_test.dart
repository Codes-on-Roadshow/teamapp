import 'package:flutter_test/flutter_test.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:integration_test/integration_test.dart';

import 'package:team_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('should show profile screen', (WidgetTester tester) async {
      app.main();
      
      await tester.pumpAndSettle();

      expect(find.text('Ranu WP'), findsOneWidget);
      expect(find.text('ranu.wp@team.com'), findsOneWidget);
      // expect(find.image(const NetworkImage('https://placekitten.com/200/200')), findsOneWidget);
    });
  });
}
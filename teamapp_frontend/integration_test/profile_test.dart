// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:team_app/main.dart' as app;

void main() {
  group('Profile', () {
    testWidgets('Profile page should have name and email', (tester) async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Ranu WP'), findsOneWidget);
      expect(find.text('ranu.wp@team.com'), findsOneWidget);
    });
  });
}

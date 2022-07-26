// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/the_app_is_running.dart';
import './step/i_login.dart';
import './step/i_tap_icon.dart';
import './step/i_see_text.dart';
import './step/i_see_image.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Profile''', () {
    testWidgets('''should show name, email, avatar and sign out''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapIcon(tester, Icons.person);
      await iSeeText(tester, 'Ranu WP');
      await iSeeText(tester, 'ranuwp@test.teamapp.com');
      await iSeeImage(tester, 'avatar-image');
      await iSeeText(tester, 'Sign Out');
    });
  });
}

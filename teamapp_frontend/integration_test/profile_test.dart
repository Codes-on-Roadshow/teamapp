// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_tap_icon.dart';
import './step/i_see_text.dart';
import './step/i_see_image.dart';

void main() {
  group('Profile', () {
    testWidgets('Profile should show name, email, and avatar', (tester) async {
      await theAppIsRunning(tester);
      await iTapIcon(tester, Icons.person);
      await iSeeText(tester, 'Ranu WP');
      await iSeeText(tester, 'ranu.wp@team.com');
      await iSeeImage(tester, 'avatar-image');
    });
  });
}

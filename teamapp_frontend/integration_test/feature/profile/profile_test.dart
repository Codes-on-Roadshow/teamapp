// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './../../step/the_app_is_running.dart';
import './../../step/i_see_text.dart';
import './../../step/i_see_image.dart';

void main() {
  group('Profile', () {
    testWidgets('Profile should show name and email', (tester) async {
      await theAppIsRunning(tester);
      await iSeeText(tester, 'Ranu WP');
      await iSeeText(tester, 'ranu.wp@team.com');
      await iSeeImage(tester, 'avatar-image');
    });
  });
}

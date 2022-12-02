// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import './step/the_app_is_running.dart';
import './step/i_login.dart';
import './step/i_tap_text.dart';
import './step/i_enter_into_input_field.dart';
import './step/i_see_text.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('''Team''', () {
    testWidgets('''Create a new team''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapText(tester, "Create Team");
      await iEnterIntoInputField(tester, "Death Note", 0);
      await iTapText(tester, "Create Team");
      await iSeeText(tester, "Invite your team using this code");
      await iSeeText(tester, "Death Note");
    });
    testWidgets('''Create a new team DevOps''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapText(tester, "Create Team");
      await iEnterIntoInputField(tester, "Death Devops", 0);
      await iTapText(tester, "Create Team");
      await iSeeText(tester, "Invite your team using this code");
      await iSeeText(tester, "Death Devops");
    });
    testWidgets('''Outline: Create a new team examples ('Product Designer')''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapText(tester, "Create Team");
      await iEnterIntoInputField(tester, 'Product Designer', 0);
      await iTapText(tester, "Create Team");
      await iSeeText(tester, "Invite your team using this code");
      await iSeeText(tester, 'Product Designer');
    });
    testWidgets('''Outline: Create a new team examples ('Product Owner')''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapText(tester, "Create Team");
      await iEnterIntoInputField(tester, 'Product Owner', 0);
      await iTapText(tester, "Create Team");
      await iSeeText(tester, "Invite your team using this code");
      await iSeeText(tester, 'Product Owner');
    });
    testWidgets('''Outline: Create a new team examples ('Engineer')''', (tester) async {
      await theAppIsRunning(tester);
      await iLogin(tester);
      await iTapText(tester, "Create Team");
      await iEnterIntoInputField(tester, 'Engineer', 0);
      await iTapText(tester, "Create Team");
      await iSeeText(tester, "Invite your team using this code");
      await iSeeText(tester, 'Engineer');
    });
  });
}

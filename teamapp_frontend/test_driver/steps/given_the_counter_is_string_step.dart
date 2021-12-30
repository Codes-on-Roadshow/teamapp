import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenTheCounterIsStringStep extends Given1WithWorld<String, FlutterWorld> {
  @override
  RegExp get pattern => RegExp("The counter is {string}");

  @override
  Future<void> executeStep(String counterText) async {
    final locator = find.text(counterText);
    await world.driver!.getText(locator);
  }
}

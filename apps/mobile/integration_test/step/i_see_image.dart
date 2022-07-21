import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> iSeeImage(WidgetTester tester, String imageKey) async {
  expect(find.byKey(Key(imageKey)), findsOneWidget);
}

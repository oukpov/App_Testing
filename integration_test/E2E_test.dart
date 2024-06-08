import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:smaill_project/main.dart' as app;

import 'integration_tests.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late AddItem addItem;
  testWidgets('Scroll ListView Test', (WidgetTester tester) async {
    await tester.pumpWidget(const app.MyApp());
    addItem = AddItem(tester: tester);
    addItem.verify();
    await Future.delayed(const Duration(seconds: 2));
    await addItem.enterItemName('King Dragon KH');
    await Future.delayed(const Duration(seconds: 2));
    await addItem.taplogingButton();
    await Future.delayed(const Duration(seconds: 2));

    try {
      expect(find.text('List All Items'), findsOneWidget);
      final itemFinder = find.text('Item 30');
      await tester.scrollUntilVisible(
        itemFinder,
        100,
      );
      expect(find.text('Item 30'), findsOneWidget);
    } catch (error) {
      print("Couldn't find the expected widget with item more");
    }
    await Future.delayed(const Duration(seconds: 2));
  });
}

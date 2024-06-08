import 'package:flutter_test/flutter_test.dart';
import 'package:smaill_project/integration/widget_keys.dart';

class AddItem {
  final WidgetTester tester;
  AddItem({required this.tester});

  void verify() {
    final loginHomePage = find.byKey(WidgetKeys.loginHomePage);
    expect(loginHomePage, findsOneWidget);
  }

  Future<void> enterItemName(String itemName) async {
    final itemNameField = find.byKey(WidgetKeys.itemName);
    expect(itemNameField, findsOneWidget);
    await tester.enterText(itemNameField, itemName);
    await tester.pump();
  }

  Future<void> taplogingButton() async {
    final savebutton = find.byKey(WidgetKeys.saveButton);
    expect(savebutton, findsOneWidget);
    await tester.tap(savebutton);
    await tester.pumpAndSettle();
  }
}

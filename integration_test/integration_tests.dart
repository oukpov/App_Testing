import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smaill_project/integration/widget_keys.dart';

class IntegrationTest {
  final WidgetTester tester;
  IntegrationTest({required this.tester});

  Future<void> verify() async {
    final homePage = find.byKey(WidgetKeys.homepage);
    expect(homePage, findsOneWidget);
  }

  Future<void> verifyTable() async {
    final homeTables = find.byKey(WidgetKeys.homeTable);
    expect(homeTables, findsOneWidget);
    await tester.tap(homeTables);
    await tester.pumpAndSettle();
  }

  Future<void> findClass() async {
    final findClass = find.byKey(WidgetKeys.findClass);
    expect(findClass, findsOneWidget);
    final appleFinder = find.text('1');
    expect(appleFinder, findsOneWidget);
    await tester.pumpAndSettle();
  }

  Future<void> findButtonAdd() async {
    final buttonAdds = find.byKey(WidgetKeys.buttonAdd);
    expect(buttonAdds, findsOneWidget);
    await tester.tap(buttonAdds);
    await tester.pumpAndSettle();
  }

  Future<void> enterItemName(String itemName) async {
    final itemNameField = find.byKey(WidgetKeys.itemName);
    expect(itemNameField, findsOneWidget);
    await tester.enterText(itemNameField, itemName);
    await tester.pump();
  }

  Future<void> dropdown() async {
    final dropdownbutton = find.byKey(WidgetKeys.dropdown);
    expect(dropdownbutton, findsOneWidget);
    await tester.tap(dropdownbutton);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Middle').last);
    await tester.pumpAndSettle();
  }

  Future<void> saveAddItem() async {
    final saveAddItems = find.byKey(WidgetKeys.saveAddItem);
    expect(saveAddItems, findsOneWidget);
    await tester.tap(saveAddItems);
    await tester.pumpAndSettle();
  }

  Future<void> findItemListview() async {
    final finditem = find.byKey(WidgetKeys.listview);
    expect(finditem, findsOneWidget);
    bool foundApple = false;
    while (!foundApple) {
      try {
        // Try to find the text "Apple"
        final appleFinder = find.text('Apple');
        expect(appleFinder, findsOneWidget);
        await tester.pumpAndSettle();
        foundApple = true;
      } catch (e) {
        // If not found, scroll the list
        await tester.drag(finditem, const Offset(0, -400));
        await tester.pumpAndSettle();
      }
    }
  }

  Future<void> enterSearchItem(String search) async {
    final searchField = find.byKey(WidgetKeys.search);
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, search);
    await tester.pump();
  }

  Future<void> savedone() async {
    final savedone = find.byKey(WidgetKeys.done);
    expect(savedone, findsOneWidget);
    await tester.tap(savedone);
    await tester.pumpAndSettle();
  }
}

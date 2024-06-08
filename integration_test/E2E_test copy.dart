import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'integration_tests.dart';
import 'package:smaill_project/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late AddItem addItem;
  group(
    "E2E - ",
    () {
      testWidgets(
        'Add Item Flow',
        (tester) async {
          await tester.pumpWidget(const app.MyApp());
          addItem = AddItem(tester: tester);
          addItem.verify();
          await Future.delayed(const Duration(seconds: 2));
          await addItem.enterItemName('King Dragon KH');
          await Future.delayed(const Duration(seconds: 2));
          await addItem.taplogingButton();
        },
      );
    },
  );
}
//flutter test integration_test/E2E_test.dart
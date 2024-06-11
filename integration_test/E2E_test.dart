import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'integration_tests.dart';
import 'package:smaill_project/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late IntegrationTest integrationTest;
  group(
    "E2E - ",
    () {
      testWidgets(
        'Add Item Flow',
        (tester) async {
          await tester.pumpWidget(const app.MyApp());
          integrationTest = IntegrationTest(tester: tester);
          await tester.pumpAndSettle();
          await integrationTest.verify();
          await Future.delayed(const Duration(seconds: 1));
          await tester.pumpAndSettle();
          await integrationTest.findButtonAdd();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.enterItemName('Apple');
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.dropdown();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.saveAddItem();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.findItemListview();
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.enterSearchItem('Apple');
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await integrationTest.savedone();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 3));
        },
      );
    },
  );
}
//flutter test integration_test/E2E_test.dart
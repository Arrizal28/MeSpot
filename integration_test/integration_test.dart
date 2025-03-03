import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mespot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Display the restaurant text after the application is run',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text("Restaurant"), findsOneWidget);
  });
}

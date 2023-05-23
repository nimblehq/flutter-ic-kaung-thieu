import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/screens/login/login_form.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

import '../test/mocks/mock_util.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginScreenTest', (WidgetTester tester) async {
    when(TestUtil.mockLoginUseCase.call(any))
        .thenAnswer((_) async => Success(MockUtil.loginDataResponse));
    await tester.pumpWidget(TestUtil.pumpWidgetWithRealApp('/'));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    // Test invalid password
    await tester.enterText(find.byKey(const Key(emailTextFormKey)), 'abc');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Please enter the valid email format.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));

    // Test invalid password
    await tester.enterText(find.byKey(const Key(passwordTextFormKey)), '123');
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Password must be at least 8 characters long.'),
        findsOneWidget);
    await tester.pump(const Duration(seconds: 2));

    await tester.enterText(find.byKey(const Key(emailTextFormKey)), '');
    await tester.enterText(find.byKey(const Key(passwordTextFormKey)), '');
    await tester.pumpAndSettle();

    // Test valid email and password
    await tester.enterText(find.byKey(const Key(emailTextFormKey)), 'abc@');
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Please enter the valid email format.'), findsNothing);
    await tester.enterText(
        find.byKey(const Key(passwordTextFormKey)), '12345678');
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Password must be at least 8 characters long.'),
        findsNothing);
    await tester.pump(const Duration(seconds: 2));

    // Test navigation to detail
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  });
}

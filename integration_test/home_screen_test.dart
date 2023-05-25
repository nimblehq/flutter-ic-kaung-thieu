import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/model/response/survey_response.dart';
import 'package:survey_flutter/screens/login/login_form.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

import '../test/mocks/mock_util.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomeScreenTest', (tester) async {
    when(TestUtil.mockLoginUseCase.call(any))
        .thenAnswer((_) async => Success(MockUtil.loginDataResponse));
    when(TestUtil.mockGetSurveysUseCase.call(any)).thenAnswer(
      (_) async => Success(
        SurveyDataResponse([
          SurveyResponse(
            id: '1',
            title: 'Scarlett Bangkok',
            coverImageUrl: mockCoverImageUrl,
          ),
          SurveyResponse(
            id: '2',
            title: 'ibis Bangkok Riverside',
            coverImageUrl: mockCoverImageUrl,
          ),
        ], MockUtil.metaResponse),
      ),
    );
    when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
      (_) async => Success(
        SurveyDetailDataResponse(
          SurveyDetailResponse(coverImageUrl: mockCoverImageUrl),
        ),
      ),
    );

    await tester.pumpWidget(TestUtil.pumpWidgetWithRealApp('/'));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(
        find.byKey(const Key(emailTextFormKey)), 'kaung@nimblehq.co');
    await tester.enterText(
        find.byKey(const Key(passwordTextFormKey)), '12345678');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    // Swipe test
    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data == 'Scarlett Bangkok',
      ),
      findsOneWidget,
    );
    await tester.fling(find.byType(PageView), const Offset(-100, 0), 700);
    await tester.pump(const Duration(milliseconds: 200));
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text && widget.data == 'ibis Bangkok Riverside',
      ),
      findsOneWidget,
    );
    await tester.pumpAndSettle();

    // Pull to refresh test
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 500));
    await tester.pump(const Duration(milliseconds: 200));
    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data == 'Scarlett Bangkok',
      ),
      findsOneWidget,
    );
    await tester.pumpAndSettle();

    // Survey detail navigation test
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
  });
}

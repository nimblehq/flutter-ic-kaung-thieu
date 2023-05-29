import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/model/response/answer_response.dart';
import 'package:survey_flutter/model/response/question_response.dart';
import 'package:survey_flutter/model/response/survey_detail_data_response.dart';
import 'package:survey_flutter/model/response/survey_detail_response.dart';
import 'package:survey_flutter/model/survey_question_model.dart';
import 'package:survey_flutter/screens/detail/survey_detail_screen.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

import '../test/mocks/mock_util.dart';
import 'utils/test_util.dart';

void main() {
  group('SurveyDetailScreen', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        'When navigated to survey detail, it shows survey detail info and start survey button',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [],
            ),
          ),
        ),
      );

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      expect(
        find.byType(ElevatedButton),
        findsOneWidget,
      );
    });

    testWidgets('When start survey is clicked, it shows intro type question',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                  text: 'intro',
                  displayType: DisplayType.intro.typeValue,
                ),
              ],
            ),
          ),
        ),
      );

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'intro',
        ),
        findsOneWidget,
      );
    });

    testWidgets('When a choice is clicked, it shows the choice as selected',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'choice',
                    displayType: DisplayType.choice.typeValue,
                    pick: PickType.one.pickValue,
                    answers: [
                      AnswerResponse(id: '1', text: 'choice 1'),
                      AnswerResponse(id: '2', text: 'choice 2'),
                    ]),
              ],
            ),
          ),
        ),
      );

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'choice',
        ),
        findsOneWidget,
      );
      await tester.tap(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'choice 2',
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(
          find.image(AssetImage(Assets.images.icChoice.path)), findsOneWidget);
    });

    testWidgets(
        'When a text is entered into the text area, it shows the text correspondingly',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'textarea',
                    displayType: DisplayType.textArea.typeValue,
                    pick: PickType.none.pickValue,
                    answers: [
                      AnswerResponse(shortText: 'comment'),
                    ]),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'hello');
      expect(
        find.text('hello'),
        findsOneWidget,
      );
    });

    testWidgets(
        'When texts are entered into the text fields, it shows the text correspondingly',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'textfield',
                    displayType: DisplayType.textField.typeValue,
                    pick: PickType.none.pickValue,
                    answers: [
                      AnswerResponse(id: '1', text: 'email'),
                      AnswerResponse(id: '2', text: 'phone'),
                    ]),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byType(TextField),
        findsNWidgets(2),
      );
      await tester.enterText(find.byType(TextField).first, 'email@');
      await tester.enterText(find.byType(TextField).last, '123');
      expect(
        find.text('email@'),
        findsOneWidget,
      );
      expect(
        find.text('123'),
        findsOneWidget,
      );
    });

    testWidgets('When an NPS answer is clicked, it shows as range selection',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'nps',
                    displayType: DisplayType.nps.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: '1'),
                      AnswerResponse(id: '2', text: '2'),
                      AnswerResponse(id: '3', text: '3'),
                      AnswerResponse(id: '4', text: '4'),
                      AnswerResponse(id: '5', text: '5'),
                      AnswerResponse(id: '6', text: '6'),
                      AnswerResponse(id: '7', text: '7'),
                      AnswerResponse(id: '8', text: '8'),
                      AnswerResponse(id: '9', text: '9'),
                      AnswerResponse(id: '10', text: '10'),
                    ]),
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      await tester.tap(
        find.text('2'),
      );
      await tester.pump(const Duration(milliseconds: 200));
      final firstSelected = tester.widget<Text>(find
          .byWidgetPredicate((widget) => widget is Text && widget.data == '1'));
      final secondSelected = tester.widget<Text>(find
          .byWidgetPredicate((widget) => widget is Text && widget.data == '2'));
      final thirdUnselected = tester.widget<Text>(find
          .byWidgetPredicate((widget) => widget is Text && widget.data == '3'));
      expect(
        firstSelected.style?.color != thirdUnselected.style?.color,
        true,
      );
      expect(
        secondSelected.style?.color != thirdUnselected.style?.color,
        true,
      );
    });

    testWidgets('When a smiley answer is clicked, it shows as single selection',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'smiley',
                    displayType: DisplayType.smiley.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: '1'),
                      AnswerResponse(id: '2', text: '2'),
                      AnswerResponse(id: '3', text: '3'),
                      AnswerResponse(id: '4', text: '4'),
                      AnswerResponse(id: '5', text: '5'),
                    ])
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      await tester.tap(find.text('😡'));
      await tester.pump(const Duration(milliseconds: 200));
      final icon1 = tester.widget<Text>(find.text('😡'));
      expect(icon1.style?.color?.opacity, null);
      final icon2 = tester.widget<Text>(find.text('😕'));
      expect(icon2.style?.color?.opacity, 0.4);
      final icon3 = tester.widget<Text>(find.text('😐'));
      expect(icon3.style?.color?.opacity, 0.4);
      final icon4 = tester.widget<Text>(find.text('🙂'));
      expect(icon4.style?.color?.opacity, 0.4);
      final icon5 = tester.widget<Text>(find.text('😄'));
      expect(icon5.style?.color?.opacity, 0.4);
    });

    testWidgets('When a star answer is clicked, it shows as range selection',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'star',
                    displayType: DisplayType.star.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: '1'),
                      AnswerResponse(id: '2', text: '2'),
                      AnswerResponse(id: '3', text: '3'),
                      AnswerResponse(id: '4', text: '4'),
                      AnswerResponse(id: '5', text: '5'),
                    ])
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      final stars = tester.widgetList<Text>(find.text('⭐'));
      await tester.tap(find.text('⭐').at(2));
      await tester.pump(const Duration(milliseconds: 200));

      expect(stars.elementAt(0).style?.color?.opacity, null);
      expect(stars.elementAt(1).style?.color?.opacity, null);
      expect(stars.elementAt(2).style?.color?.opacity, null);
      expect(stars.elementAt(3).style?.color?.opacity, 0.4);
      expect(stars.elementAt(4).style?.color?.opacity, 0.4);
    });

    testWidgets('When a thumb answer is clicked, it shows as range selection',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'thumb',
                    displayType: DisplayType.thumbs.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: '1'),
                      AnswerResponse(id: '2', text: '2'),
                      AnswerResponse(id: '3', text: '3'),
                      AnswerResponse(id: '4', text: '4'),
                      AnswerResponse(id: '5', text: '5'),
                    ])
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      final stars = tester.widgetList<Text>(find.text('👍'));
      await tester.tap(find.text('👍').at(2));
      await tester.pump(const Duration(milliseconds: 200));

      expect(stars.elementAt(0).style?.color?.opacity, null);
      expect(stars.elementAt(1).style?.color?.opacity, null);
      expect(stars.elementAt(2).style?.color?.opacity, null);
      expect(stars.elementAt(3).style?.color?.opacity, 0.4);
      expect(stars.elementAt(4).style?.color?.opacity, 0.4);
    });

    testWidgets('When a heart answer is clicked, it shows as range selection',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'heart',
                    displayType: DisplayType.heart.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: '1'),
                      AnswerResponse(id: '2', text: '2'),
                      AnswerResponse(id: '3', text: '3'),
                      AnswerResponse(id: '4', text: '4'),
                      AnswerResponse(id: '5', text: '5'),
                    ])
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      final stars = tester.widgetList<Text>(find.text('❤️'));
      await tester.tap(find.text('❤️').at(2));
      await tester.pump(const Duration(milliseconds: 200));

      expect(stars.elementAt(0).style?.color?.opacity, null);
      expect(stars.elementAt(1).style?.color?.opacity, null);
      expect(stars.elementAt(2).style?.color?.opacity, null);
      expect(stars.elementAt(3).style?.color?.opacity, 0.4);
      expect(stars.elementAt(4).style?.color?.opacity, 0.4);
    });

    testWidgets('When question is dropdown, it shows picker', (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                    text: 'dropdown',
                    displayType: DisplayType.dropdown.typeValue,
                    answers: [
                      AnswerResponse(id: '1', text: 'Answer 1'),
                      AnswerResponse(id: '2', text: 'Answer 2'),
                      AnswerResponse(id: '3', text: 'Answer 3'),
                      AnswerResponse(id: '4', text: 'Answer 4'),
                      AnswerResponse(id: '5', text: 'Answer 5'),
                    ])
              ],
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        TestUtil.pumpWidgetWithShellApp(
          const SurveyDetailScreen(
            surveyId: 'id',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoPicker), findsOneWidget);
    });

    testWidgets('When survey reached the end, it shows outro type question',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                  text: 'outro',
                  displayType: DisplayType.outro.typeValue,
                ),
              ],
            ),
          ),
        ),
      );

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'outro',
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'When submit survey button is clicked and submits the answers successfully, it shows lottie',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                  text: 'outro',
                  displayType: DisplayType.outro.typeValue,
                ),
              ],
            ),
          ),
        ),
      );

      when(TestUtil.mockSubmitSurveyUseCase.call(any))
          .thenAnswer((_) async => Success(null));

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'outro',
        ),
        findsOneWidget,
      );

      final submitButton = find.byType(ElevatedButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(
        find.byType(Lottie),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });

    testWidgets(
        'When submit survey button is clicked and submits the answers unsuccessfully, it shows error dialog',
        (tester) async {
      when(TestUtil.mockGetSurveyDetailUseCase.call(any)).thenAnswer(
        (_) async => Success(
          SurveyDetailDataResponse(
            SurveyDetailResponse(
              title: 'welcome survey',
              coverImageUrl: mockCoverImageUrl,
              questions: [
                QuestionResponse(
                  text: 'outro',
                  displayType: DisplayType.outro.typeValue,
                ),
              ],
            ),
          ),
        ),
      );

      when(TestUtil.mockSubmitSurveyUseCase.call(any)).thenAnswer((_) async =>
          Failed(
              UseCaseException(const NetworkExceptions.unauthorisedRequest())));

      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const SurveyDetailScreen(
        surveyId: 'id',
      )));
      await tester.pumpAndSettle();

      final startSurveyButton = find.byType(ElevatedButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is Text && widget.data == 'outro',
        ),
        findsOneWidget,
      );

      final submitButton = find.byType(ElevatedButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Unable to submit'),
        findsOneWidget,
      );
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey_flutter/model/hives/survey.dart';

const String surveysBoxKey = 'surveys';

void setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SurveyAdapter());
}

final hiveStorageProvider = Provider((ref) {
  return HiveStorageImpl();
});

abstract class HiveStorage {
  Future<void> saveSurveys(List<Survey> surveys, bool shouldClear);

  Future<List<Survey>> getSurveys(int numberOfSurvey);
}

class HiveStorageImpl extends HiveStorage {
  @override
  Future<void> saveSurveys(List<Survey> surveys, bool shouldClear) async {
    final Box<Survey> surveysBox = await Hive.openBox(surveysBoxKey);
    if (shouldClear) {
      await surveysBox.clear();
    }
    await surveysBox.addAll(surveys);
    surveysBox.close();
  }

  @override
  Future<List<Survey>> getSurveys(int numberOfSurvey) async {
    final Box<Survey> surveysBox = await Hive.openBox(surveysBoxKey);
    final surveys = surveysBox
        .valuesBetween(startKey: 0, endKey: numberOfSurvey - 1)
        .toList();
    surveysBox.close();
    return surveys;
  }
}

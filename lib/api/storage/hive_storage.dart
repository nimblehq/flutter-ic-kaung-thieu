import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:survey_flutter/model/hives/survey.dart';

const String surveysBoxKey = 'surveys';
Box<Survey>? surveysBox;

void setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SurveyAdapter());
}

final hiveStorageProvider = Provider((ref) {
  _setupBox();
  ref.onDispose(() {
    surveysBox?.close();
  });
  return HiveStorageImpl();
});

void _setupBox() async {
  surveysBox = await Hive.openBox(surveysBoxKey);
}

abstract class HiveStorage {
  Future<void> saveSurveys(List<Survey> surveys, bool shouldClear);

  Future<List<Survey>> getSurveys(int numberOfSurvey);
}

class HiveStorageImpl extends HiveStorage {
  @override
  Future<void> saveSurveys(List<Survey> surveys, bool shouldClear) async {
    if (shouldClear) {
      await surveysBox?.clear();
    }
    await surveysBox?.addAll(surveys);
  }

  @override
  Future<List<Survey>> getSurveys(int numberOfSurvey) async {
    final surveys = surveysBox
        ?.valuesBetween(startKey: 0, endKey: numberOfSurvey - 1)
        .toList();
    return surveys ?? List.empty();
  }
}

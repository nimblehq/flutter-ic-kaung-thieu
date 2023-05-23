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

  Future<List<Survey>> getSurveys();

  Future<int> clearSurveys();
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
  Future<List<Survey>> getSurveys() async {
    final surveys = surveysBox?.values.toList();
    return surveys ?? List.empty();
  }

  @override
  Future<int> clearSurveys() async {
    return await surveysBox?.clear() ?? 0;
  }
}

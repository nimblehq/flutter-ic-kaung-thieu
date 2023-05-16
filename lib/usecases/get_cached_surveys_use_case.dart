import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getCachedSurveysUseCaseProvider =
    Provider((ref) => GetCachedSurveysUseCase(ref.watch(hiveStorageProvider)));

class GetCachedSurveysUseCase extends NoParamsUseCase<List<Survey>> {
  final HiveStorage _hiveStorage;

  GetCachedSurveysUseCase(this._hiveStorage);

  @override
  Future<Result<List<Survey>>> call() async {
    final surveys = await _hiveStorage.getSurveys();
    return Success(surveys);
  }
}

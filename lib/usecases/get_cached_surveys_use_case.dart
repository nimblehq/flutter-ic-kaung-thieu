import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/model/response/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getCachedSurveyUseCaseProvider =
    Provider((ref) => GetCachedSurveyUseCase(ref.watch(hiveStorageProvider)));

class GetCachedSurveyUseCase extends UseCase<List<Survey>, SurveysParameters> {
  final HiveStorage _hiveStorage;

  GetCachedSurveyUseCase(this._hiveStorage);

  @override
  Future<Result<List<Survey>>> call(SurveysParameters params) async {
    final surveys =
        await _hiveStorage.getSurveys(params.pageSize * params.pageNumber);
    return Success(surveys);
  }
}

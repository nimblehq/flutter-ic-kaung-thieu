import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final clearCachedSurveysUseCaseProvider = Provider(
    (ref) => ClearCachedSurveysUseCase(ref.watch(hiveStorageProvider)));

class ClearCachedSurveysUseCase extends NoParamsUseCase<int> {
  final HiveStorage _hiveStorage;

  ClearCachedSurveysUseCase(this._hiveStorage);

  @override
  Future<Result<int>> call() async {
    final result = await _hiveStorage.clearSurveys();
    return Success(result);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final clearCachedSurveysUseCaseProvider = Provider(
    (ref) => ClearCachedSurveysUseCase(ref.watch(hiveStorageProvider)));

class ClearCachedSurveysUseCase extends NoParamsUseCase<void> {
  final HiveStorage _hiveStorage;

  ClearCachedSurveysUseCase(this._hiveStorage);

  @override
  Future<Result<void>> call() async {
    await _hiveStorage.clearSurveys();
    return Success(null);
  }
}

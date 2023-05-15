import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final getCachedNumberOfPageUseCaseProvider = Provider(
  (ref) => GetCachedNumberOfPageUseCase(ref.watch(hiveStorageProvider)),
);

class GetCachedNumberOfPageUseCase extends NoParamsUseCase<int> {
  final HiveStorage _hiveStorage;

  GetCachedNumberOfPageUseCase(this._hiveStorage);

  @override
  Future<Result<int>> call() async {
    final result = await _hiveStorage.getNumberOfPage();
    return Success(result);
  }
}

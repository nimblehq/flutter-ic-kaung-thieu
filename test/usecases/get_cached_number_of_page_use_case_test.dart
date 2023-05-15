import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_number_of_page_use_case.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCachedNumberOfPageUseCase', () {
    MockHiveStorage mockHiveStorage = MockHiveStorage();

    late GetCachedNumberOfPageUseCase getCachedNumberOfPageUseCase;

    setUp(() => getCachedNumberOfPageUseCase =
        GetCachedNumberOfPageUseCase(mockHiveStorage));

    test('When get cached number of page, it emits success', () async {
      when(mockHiveStorage.getNumberOfPage()).thenAnswer((_) async => 2);

      final result = await getCachedNumberOfPageUseCase.call();
      expect(result is Success<int>, true);
    });
  });
}

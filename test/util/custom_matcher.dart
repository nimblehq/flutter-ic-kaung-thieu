import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:survey_flutter/api/exception/network_exceptions.dart';

// FIXME: AsyncLoading<void>() != AsyncLoading<void>(value: null) workaround
final isLoading = isNot(
  // If the captured data is not AsyncData or AsyncError, it is AsyncLoading
  isIn([
    const AsyncData<void>(null),
    AsyncError<void>(NetworkExceptions, StackTrace.current),
  ]),
);

// FIXME: AsyncError<void>() != AsyncError<void>(value: null) workaround
final isError = isNot(
  // If the captured data is not AsyncData or AsyncLoading, it is AsyncError
  isIn([
    const AsyncLoading<void>(),
    const AsyncData(null),
  ]),
);

import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';
import 'package:survey_flutter/usecases/login_use_case.dart';

import '../../test/mocks/generate_mocks.mocks.dart';

class TestUtil {
  static MockLoginUseCase mockLoginUseCase = MockLoginUseCase();
  static MockGetSurveysUseCase mockGetSurveysUseCase = MockGetSurveysUseCase();

  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return ProviderScope(
      overrides: [
        loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
        getSurveysUseCaseProvider.overrideWithValue(mockGetSurveysUseCase),
      ],
      child: MyApp(),
    );
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return ProviderScope(
      overrides: [
        loginUseCaseProvider.overrideWithValue(mockLoginUseCase),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
        appName: 'Flutter templates testing',
        packageName: '',
        version: '',
        buildNumber: '',
        buildSignature: '');
    FlutterConfigPlus.loadValueForTesting({
      'SECRET': 'This is only for testing',
      'CLIENT_ID': 'CLIENT_ID',
      'CLIENT_SECRET': 'CLIENT_SECRET',
      'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
    });
    setupHive();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey_flutter/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

class TestUtil {
  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return MyApp();
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
        appName: 'Flutter templates testing',
        packageName: '',
        version: '',
        buildNumber: '',
        buildSignature: '');
    FlutterConfigPlus.loadValueForTesting(
        {'SECRET': 'This is only for testing'});
  }
}

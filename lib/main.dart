import 'package:flutter/material.dart';
import 'package:flutter_config_plus/flutter_config_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:survey_flutter/api/storage/hive_storage.dart';
import 'package:survey_flutter/screens/detail/survey_detail_screen.dart';
import 'package:survey_flutter/screens/home/home_screen.dart';
import 'package:survey_flutter/theme/app_theme.dart';
import 'package:survey_flutter/screens/login/login_screen.dart';
import 'package:survey_flutter/screens/splash/splash.dart';
import 'package:survey_flutter/utils/string_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfigPlus.loadEnvVariables();
  setupHive();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

const routePathSplashScreen = '/';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: routePathSplashScreen,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: routePathLoginScreen,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
          path: routePathHomeScreen,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
          routes: [
            GoRoute(
              path: 'survey_detail/:surveyId',
              builder: (BuildContext context, GoRouterState state) =>
                  SurveyDetailScreen(
                      surveyId: state.params["surveyId"].orEmpty()),
            ),
          ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

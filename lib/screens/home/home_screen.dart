import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_view_model.dart';
import 'package:survey_flutter/theme/constant.dart';

import 'home_shimmer_loading.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  TextTheme get _textTheme => Theme.of(context).textTheme;

  AppLocalizations get _localizations => AppLocalizations.of(context)!;
  late BuildContext _scaffoldContext;
  int _selectedPage = 0;

  final _shouldShowShimmerProvider = StreamProvider.autoDispose<bool>(
      (ref) => ref.watch(homeViewModelProvider.notifier).shouldShowShimmer);
  final _currentDateStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(homeViewModelProvider.notifier).currentDate);
  final _surveysStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(homeViewModelProvider.notifier).surveys);
  final _profileStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(homeViewModelProvider.notifier).profile);
  final _isLoadMoreStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(homeViewModelProvider.notifier).isLoadMore);
  final _isErrorStreamProvider = StreamProvider.autoDispose(
      (ref) => ref.watch(homeViewModelProvider.notifier).isError);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(builder: (BuildContext context) {
        _scaffoldContext = context;

        var error = ref.watch(_isErrorStreamProvider).value ?? '';
        if (error.isNotEmpty) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => createSnackBar(error));
          ref.read(homeViewModelProvider.notifier).clearError();
        }

        var isShimmerLoading =
            ref.watch(_shouldShowShimmerProvider).value ?? false;
        return Stack(
          children: [
            Visibility(
              visible: isShimmerLoading,
              child: const HomeShimmerLoading(),
            ),
            Visibility(
              visible: !isShimmerLoading,
              child: _buildHomeScreenContent(),
            )
          ],
        );
      }),
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(snackBar);
  }

  Widget _buildHomeScreenContent() {
    final pageController = PageController(initialPage: _selectedPage);

    var imageUrl = ref.watch(_profileStreamProvider).value?.imageUrl ?? '';

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              _selectedPage = page;
            });
            if (page ==
                (ref.watch(_surveysStreamProvider).value?.length ?? 0) - 2) {
              ref.read(homeViewModelProvider.notifier).getSurveyList();
            }
          },
          children: ref
                  .watch(_surveysStreamProvider)
                  .value
                  ?.map((survey) => _buildBackgroundImage(survey.coverImageUrl))
                  .toList() ??
              [],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Metrics.spacingDefault,
              top: Metrics.spacingXLarge,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.watch(_currentDateStreamProvider).value ?? '',
                  style: _textTheme.bodyLarge?.copyWith(
                    fontSize: Metrics.fontXSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Metrics.spacingXXSmall,
                  ),
                  child: Text(
                    _localizations.homeTodayTitle,
                    style: _textTheme.bodyLarge?.copyWith(
                      fontSize: Metrics.fontLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: imageUrl.isNotEmpty,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Metrics.spacingXXLarge,
                right: Metrics.spacingDefault,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(Metrics.profileSmallRadius),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageViewDotIndicator(
                currentItem: _selectedPage,
                count: ref.watch(_surveysStreamProvider).value?.length ?? 1,
                unselectedColor: Colors.white24,
                selectedColor: Colors.white,
                duration: const Duration(
                  milliseconds: Metrics.pageIndicatorAnimationDuration,
                ),
                alignment: Alignment.bottomLeft,
                size: const Size(
                  Metrics.pageIndicatorSize,
                  Metrics.pageIndicatorSize,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Metrics.spacingDefault,
                    top: Metrics.spacingMedium,
                    right: Metrics.spacingDefault),
                child: Text(
                  ref
                          .watch(_surveysStreamProvider)
                          .value?[_selectedPage]
                          .title ??
                      '',
                  maxLines: 2,
                  style: _textTheme.bodyLarge?.copyWith(
                    fontSize: Metrics.fontMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Metrics.spacingDefault,
                        Metrics.spacingSmall,
                        Metrics.spacingDefault,
                        Metrics.spacingLarge,
                      ),
                      child: Text(
                        ref
                                .watch(_surveysStreamProvider)
                                .value?[_selectedPage]
                                .description ??
                            '',
                        maxLines: 2,
                        style: _textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          fontSize: Metrics.fontNormal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Metrics.spacingSmall,
                      right: Metrics.spacingDefault,
                      bottom: Metrics.spacingLarge,
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        // TODO implement go to detail
                      },
                      backgroundColor: Colors.white,
                      child: Image.asset(Assets.images.icNavNext.path),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Visibility(
            visible: ref.watch(_isLoadMoreStreamProvider).value ?? false,
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        Image.asset(
          Assets.images.imageOverlay.path,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:survey_flutter/gen/assets.gen.dart';
import 'package:survey_flutter/screens/home/home_view_model.dart';

import 'home_shimmer_loading.dart';

const routePathHomeScreen = '/home';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  TextTheme get _textTheme => Theme.of(context).textTheme;
  late BuildContext _scaffoldContext;
  int _selectedPage = 0;
  bool _isLoading = false;
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(homeViewModelProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final viewModelProvider = ref.watch(homeViewModelProvider);

    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Builder(builder: (BuildContext context) {
          _scaffoldContext = context;
          return viewModelProvider.when(
            data: (result) {
              if (viewModel.shouldShowShimmer) {
                return const HomeShimmerLoading();
              } else {
                _isLoading = false;
                return _buildHomeScreenContent();
              }
            },
            error: (error, stack) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => createSnackBar((error as Exception).toString()),
              );
              _isLoading = false;
              return _buildHomeScreenContent();
            },
            loading: () {
              // This is for load more
              _isLoading = true;
              return _buildHomeScreenContent();
            },
          );
        }),
      );
    });
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(snackBar);
  }

  Widget _buildHomeScreenContent() {
    final pageController = PageController(initialPage: _selectedPage);

    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        PageView(
          controller: pageController,
          onPageChanged: (page) {
            setState(() {
              _selectedPage = page;
              if (page == viewModel.surveys.length - 2) {
                ref.read(homeViewModelProvider.notifier).getSurveyList();
              }
            });
          },
          children: viewModel.surveys
              .map((survey) => _buildBackgroundImage(survey.coverImageUrl))
              .toList(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.currentDate,
                  style: _textTheme.bodyLarge?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Today',
                    style: _textTheme.bodyLarge?.copyWith(
                      fontSize: 34,
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
          visible: viewModel.profile != null,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 79, right: 20),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(18),
                  child: Image.network(
                    viewModel.profile?.imageUrl ?? '',
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
                count: viewModel.surveys.length,
                unselectedColor: Colors.white24,
                selectedColor: Colors.white,
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.bottomLeft,
                size: const Size(8, 8),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 26, right: 20),
                child: Text(
                  viewModel.surveys[_selectedPage].title,
                  maxLines: 2,
                  style: _textTheme.bodyLarge?.copyWith(
                    fontSize: 28,
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
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 54),
                      child: Text(
                        viewModel.surveys[_selectedPage].description,
                        maxLines: 2,
                        style: _textTheme.bodyLarge
                            ?.copyWith(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 20, bottom: 54),
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
            visible: _isLoading,
            child: const CircularProgressIndicator(),
          ),
        )
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

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/model/profile_model.dart';
import 'package:survey_flutter/model/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_number_of_page_use_case.dart';
import 'package:survey_flutter/usecases/get_cached_surveys_use_case.dart';
import 'package:survey_flutter/usecases/get_surveys_use_case.dart';

const pageSize = 5;

final homeViewModelProvider =
    AsyncNotifierProvider.autoDispose<HomeViewModel, void>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeAsyncNotifier<void> {
  var _surveyCache = <SurveyModel>[];

  final _surveys = StreamController<List<SurveyModel>>();

  Stream<List<SurveyModel>> get surveys => _surveys.stream;

  final _profile = StreamController<ProfileModel>();

  Stream<ProfileModel> get profile => _profile.stream;

  final _currentDate = StreamController<String>();

  Stream<String> get currentDate => _currentDate.stream;

  final _isError = StreamController<String>();

  Stream<String> get isError => _isError.stream;

  final _isLoadMore = StreamController<bool>();

  Stream<bool> get isLoadMore => _isLoadMore.stream;

  final _shouldShowShimmer = StreamController<bool>();

  Stream<bool> get shouldShowShimmer => _shouldShowShimmer.stream;

  var _pageNumber = 0;

  @override
  FutureOr<void> build() {
    fetchData();
    ref.onDispose(() async {
      await _surveys.close();
      await _profile.close();
      await _currentDate.close();
      await _isError.close();
      await _isLoadMore.close();
      await _shouldShowShimmer.close();
    });
  }

  void fetchData() {
    _surveyCache.clear();
    getSurveyList();
    getProfile();
    getCurrentDate();
  }

  void showOrHideLoadMore(bool show) {
    _isLoadMore.add(show);
  }

  void showOrHideShimmer(bool show) {
    _shouldShowShimmer.add(show);
  }

  void clearError() {
    _isError.add('');
  }

  Future<void> getCurrentDate() async {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, MMMM d');
    _currentDate.add(formatter.format(now).toUpperCase());
  }

  Future<void> getSurveyList() async {
    final numberOfPage =
        await ref.read(getCachedNumberOfPageUseCaseProvider).call();
    if (numberOfPage is Success<int> &&
        numberOfPage.value == _pageNumber &&
        _pageNumber != 0) {
      return;
    }

    _pageNumber += 1;

    if (_surveyCache.isEmpty) {
      showOrHideShimmer(true);
    } else {
      showOrHideLoadMore(true);
    }

    _getCacheSurveys();
  }

  void _getCacheSurveys() async {
    final result = await ref.read(getCachedSurveyUseCaseProvider).call(
          SurveysParameters(
            pageNumber: _pageNumber,
            pageSize: pageSize,
          ),
        );

    if (result is Success) {
      final cachedSurveys = (result as Success<List<Survey>>).value;
      final previousSize = (_pageNumber * pageSize) - pageSize;
      if (cachedSurveys.length > previousSize) {
        _surveyCache =
            cachedSurveys.map((survey) => survey.toSurveyModel()).toList();
        _surveys.add(_surveyCache);
        showOrHideShimmer(false);
        showOrHideLoadMore(false);
      } else {
        _getSurveysFromNetwork();
      }
    } else if (result is Failed) {
      _isError.add((result as Failed).getErrorMessage());
      showOrHideShimmer(false);
      showOrHideLoadMore(false);
    }
  }

  void _getSurveysFromNetwork() async {
    final result = await ref.read(getSurveysUseCaseProvider).call(
          SurveysParameters(
            pageNumber: _pageNumber,
            pageSize: pageSize,
          ),
        );

    if (result is Success) {
      _getCacheSurveys();
    } else if (result is Failed) {
      _isError.add((result).getErrorMessage());
      showOrHideShimmer(false);
      showOrHideLoadMore(false);
    }
  }

  Future<void> getProfile() async {
    // TODO replace with usecase in integration ticket
    Future.delayed(const Duration(seconds: 5), () {
      _profile.add(ProfileModel(imageUrl: 'https://picsum.photos/id/64/100'));
    });
  }
}

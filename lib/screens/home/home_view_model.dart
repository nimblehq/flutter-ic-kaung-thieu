import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter/model/hives/survey.dart';
import 'package:survey_flutter/model/response/survey_data_response.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/model/profile_model.dart';
import 'package:survey_flutter/model/surveys_parameters.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';
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
  int? _numberOfPage;

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
    _pageNumber += 1;
    if (_numberOfPage != null && _pageNumber > (_numberOfPage ?? 0)) {
      return;
    }
    _getSurveysFromNetwork();

    if (_surveyCache.isEmpty) {
      showOrHideShimmer(true);
    } else {
      showOrHideLoadMore(true);
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
      final successValue = (result as Success<SurveyDataResponse>).value;
      _surveyCache.addAll(successValue.surveys
          .map((survey) => survey.toSurveyModel())
          .toList());
      _numberOfPage = successValue.meta.pages;
      _surveys.add(_surveyCache);
    } else if (result is Failed) {
      _getCacheSurveys();
      _isError.add((result as Failed).getErrorMessage());
    }
    showOrHideShimmer(false);
    showOrHideLoadMore(false);
  }

  void _getCacheSurveys() async {
    final result = await ref.read(getCachedSurveysUseCaseProvider).call();

    if (result is Success) {
      final cachedSurveys = (result as Success<List<Survey>>).value;
      _surveyCache =
          cachedSurveys.map((survey) => survey.toSurveyModel()).toList();
      _surveys.add(_surveyCache);
    } else if (result is Failed) {
      _isError.add((result as Failed).getErrorMessage());
    }
    showOrHideShimmer(false);
    showOrHideLoadMore(false);
  }

  Future<void> getProfile() async {
    // TODO replace with usecase in integration ticket
    Future.delayed(const Duration(seconds: 5), () {
      _profile.add(ProfileModel(imageUrl: 'https://picsum.photos/id/64/100'));
    });
  }
}

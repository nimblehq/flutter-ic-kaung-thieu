import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/model/profile_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final homeViewModelProvider =
    AsyncNotifierProvider.autoDispose<HomeViewModel, void>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeAsyncNotifier<void> {
  final _surveyCache = <SurveyModel>[];

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

  @override
  FutureOr<void> build() {
    refresh();
  }

  void refresh() {
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
    if (_surveyCache.isEmpty) {
      showOrHideShimmer(true);
    } else {
      showOrHideLoadMore(true);
    }

    // TODO replace with usecase in integration
    Future.delayed(const Duration(seconds: 2), () {
      _surveyCache.addAll((_mockList(_surveyCache.length) as Success).value);
      _surveys.add(_surveyCache);
      showOrHideShimmer(false);
      showOrHideLoadMore(false);
    });

    // TODO remove this in integration
    Future.delayed(const Duration(seconds: 4), () {
      var exception = Exception('Test error');
      _surveys.addError(exception, StackTrace.current);
      _isError.add('Test error');
    });
  }

  Future<void> getProfile() async {
    // TODO replace with usecase in integration ticket
    Future.delayed(const Duration(seconds: 5), () {
      _profile.add(ProfileModel(imageUrl: 'https://picsum.photos/id/64/100'));
    });
  }

  Result<List<SurveyModel>> _mockList(int size) {
    return Success([
      SurveyModel(
        title: '${size + 1} Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: '${size + 2} Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: '${size + 3} Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: '${size + 4} Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: '${size + 5} Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
    ]);
  }
}

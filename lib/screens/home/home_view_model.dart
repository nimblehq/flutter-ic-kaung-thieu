import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:survey_flutter/model/survey_model.dart';
import 'package:survey_flutter/model/profile_model.dart';
import 'package:survey_flutter/usecases/base/base_use_case.dart';

final homeViewModelProvider =
    AsyncNotifierProvider.autoDispose<HomeViewModel, dynamic>(
        HomeViewModel.new);

class HomeViewModel extends AutoDisposeAsyncNotifier {
  final _surveys = <SurveyModel>[];
  List<SurveyModel> get surveys => _surveys;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  bool get shouldShowShimmer => _surveys.isEmpty;

  String _currentDate = '';
  String get currentDate => _currentDate;

  @override
  FutureOr<dynamic> build() {
    refresh();
  }

  void refresh() {
    getSurveyList();
    getProfile();
    getCurrentDate();
  }

  Future<void> getCurrentDate() async {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, MMMM d');
    _currentDate = formatter.format(now).toUpperCase();
    state = AsyncValue.data(_currentDate);
  }

  Future<void> getSurveyList() async {
    state = const AsyncValue.loading();

    // TODO replace with usecase in integration ticket
    Future.delayed(const Duration(seconds: 2), () {
      _surveys.addAll((_mockList() as Success).value);
      state = AsyncValue.data(_surveys);
    });

    Future.delayed(const Duration(seconds: 4), () {
      final exception = Exception("Test Error");
      state = AsyncValue.error(exception, StackTrace.current);
    });
  }

  Future<void> getProfile() async {
    state = const AsyncValue.loading();

    // TODO replace with usecase in integration ticket
    Future.delayed(const Duration(seconds: 5), () {
      _profile = ProfileModel(imageUrl: 'https://picsum.photos/id/64/100');
      state = AsyncValue.data(_profile);
    });
  }

  Result<List<SurveyModel>> _mockList() {
    return Success([
      SurveyModel(
        title: 'Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: 'Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: 'Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: 'Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
      SurveyModel(
        title: 'Working from home Check-In',
        description:
            'We would like to know how you feel about our work from home. We would like to know how you feel about our work from home.',
        coverImageUrl: 'https://picsum.photos/376/812',
      ),
    ]);
  }
}

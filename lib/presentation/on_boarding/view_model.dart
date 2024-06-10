import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/models.dart';
import '../_resources/assets_manager.dart';
import '../_resources/constants_manager.dart';
import '../_resources/strings_manager.dart';

class OnBoardingCtrl extends Cubit<int> {
  OnBoardingCtrl() : super(0);

  List<SliderObject> get slidersData => _getSliderData;

  PageController get controller => _pageController;

  final _pageController = PageController(initialPage: 0);

  void changeOnBoardPageIndex(int index) {
    emit(index);
  }

  void nextPage() {
    int index = state;
    _pageController.animateToPage(
      ++index,
      duration: const Duration(
        milliseconds: AppConstants.durationAnimationDelay3,
      ),
      curve: Curves.linear,
    );
  }

  final List<SliderObject> _getSliderData = [
    SliderObject(AppStrings.onBoardTitle1, AppAssets.onBoardingImg1),
    SliderObject(AppStrings.onBoardTitle2, AppAssets.onBoardingImg2),
    SliderObject(AppStrings.onBoardTitle3, AppAssets.onBoardingImg3),
  ];
}

import 'package:donation/presentation/_resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../domain/model/models.dart';
import '../_resources/strings_manager.dart';

class OnBoardingVM extends ChangeNotifier {

  List<SliderObject> get slidersData => _getSliderData;

  int currentIndex = 0;

  void changeOnBoardPageIndex(int index) {
    currentIndex = index;
    print('index');
    notifyListeners();
  }

  final List<SliderObject> _getSliderData = [
    SliderObject(AppStrings.onBoardTitle1, AppAssets.onBoardingImg1),
    SliderObject(AppStrings.onBoardTitle2, AppAssets.onBoardingImg2),
    SliderObject(AppStrings.onBoardTitle3, AppAssets.onBoardingImg3),
  ];
}

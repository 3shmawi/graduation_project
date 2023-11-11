import 'package:donation/presentation/_resources/color_manager.dart';
import 'package:donation/presentation/_resources/constants_manager.dart';
import 'package:donation/presentation/_resources/strings_manager.dart';
import 'package:donation/presentation/on_boarding/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../domain/model/models.dart';
import '../_resources/routes_manager.dart';
import '../_resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _appPreferences.setOnBoardingScreenViewed();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnBoardingVM>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSize.s60),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: provider.slidersData.length,
                onPageChanged: (index) {
                  Provider.of<OnBoardingVM>(context, listen: false)
                      .changeOnBoardPageIndex(index);
                },
                itemBuilder: (_, index) {
                  return OnBoardingPage(provider.slidersData[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  provider.slidersData.length,
                  (index) => _getProperCircle(index, provider),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_isLast(provider)) {
                  Navigator.pushReplacementNamed(context, Routes.layoutRoute);
                } else {
                  _pageController.animateToPage(
                    ++provider.currentIndex,
                    duration: const Duration(
                        milliseconds: AppConstants.duraitonAnimationDelay),
                    curve: Curves.bounceInOut,
                  );
                }
              },
              child: Text(
                _isLast(provider) ? AppStrings.getStarted : AppStrings.next,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
              child: AnimatedCrossFade(
                firstChild: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.layoutRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                secondChild: const SizedBox(),
                crossFadeState: _isLast(provider)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(
                  milliseconds: AppConstants.duraitonAnimationDelay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isLast(OnBoardingVM provider) {
    return provider.currentIndex == provider.slidersData.length - 1;
  }

  Widget _getProperCircle(int index, OnBoardingVM vm) {
    return Container(
      height: AppSize.s14,
      width: AppSize.s14,
      margin: const EdgeInsets.all(AppMargin.m8),
      decoration: BoxDecoration(
        color:
            index == vm.currentIndex ? AppColors.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: AppSize.s1_5,
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _sliderObject.image,
            height: AppSize.s400,
            width: AppSize.s420,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              _sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const SizedBox(
            height: AppSize.s60,
          ),
        ],
      ),
    );
  }
}

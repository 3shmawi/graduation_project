import 'package:easy_localization/easy_localization.dart';

import '../../app/global_imports.dart';
import 'package:donation/presentation/on_boarding/view_model.dart';
import 'package:flutter/services.dart';

import '../../domain/model/models.dart';
import '../_resources/routes_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnBoardingVM>();

    return Scaffold(
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
            const SizedBox(height: AppHeight.h60),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: cubit.slidersData.length,
                onPageChanged: (index) {
                  context.read<OnBoardingVM>().changeOnBoardPageIndex(index);
                },
                itemBuilder: (_, index) {
                  return OnBoardingPage(cubit.slidersData[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  cubit.slidersData.length,
                  (index) => _getProperCircle(index, cubit),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_isLast(cubit)) {
                  Navigator.pushReplacementNamed(context, Routes.authRoute);
                } else {
                  _pageController.animateToPage(
                    ++cubit.currentIndex,
                    duration: const Duration(
                      milliseconds: AppConstants.durationAnimationDelay3,
                    ),
                    curve: Curves.linear,
                  );
                }
              },
              child: Text(
                _isLast(cubit) ? AppStrings.getStarted : AppStrings.next,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
              child: AnimatedCrossFade(
                firstChild: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.authRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                secondChild: const SizedBox(),
                crossFadeState: _isLast(cubit)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(
                  milliseconds: AppConstants.durationAnimationDelay3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isLast(OnBoardingVM cubit) {
    return cubit.currentIndex == cubit.slidersData.length - 1;
  }

  Widget _getProperCircle(int index, OnBoardingVM vm) {
    return Container(
      height: AppHeight.h14,
      width: AppWidth.w14,
      margin: const EdgeInsets.all(AppMargin.m8),
      decoration: BoxDecoration(
        color:
            index == vm.currentIndex ? AppColors.primary : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary,
          width: AppWidth.w1_5,
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            _sliderObject.image,
            height: AppHeight.h400,
            width: AppWidth.w420,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(
              _sliderObject.title.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    height: 2,
                  ),
            ),
          ),
          const SizedBox(
            height: AppHeight.h60,
          ),
        ],
      ),
    );
  }
}

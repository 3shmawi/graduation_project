import '../../app/global_imports.dart';
import 'package:donation/presentation/on_boarding/view_model.dart';
import 'package:flutter/services.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../domain/model/models.dart';
import '../_resources/routes_manager.dart';

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
    final cubit = context.watch<OnBoardingVM>();

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
        padding:  EdgeInsets.symmetric(horizontal: AppPadding.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: AppSize.s60),
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
              padding:  EdgeInsets.only(bottom: AppPadding.p20),
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
                    duration:  const Duration(
                        milliseconds: AppConstants.duraitonAnimationDelay),
                    curve: Curves.linear,
                  );
                }
              },
              child: Text(
                _isLast(cubit) ? AppStrings.getStarted : AppStrings.next,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: AppPadding.p8),
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
                secondChild:  const SizedBox(),
                crossFadeState: _isLast(cubit)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration:  const Duration(
                  milliseconds: AppConstants.duraitonAnimationDelay,
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
      height: AppSize.s14,
      width: AppSize.s14,
      margin:  EdgeInsets.all(AppMargin.m8),
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

   const OnBoardingPage(this._sliderObject, {super.key});

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
            padding:  EdgeInsets.all(AppPadding.p8),
            child: Text(
              _sliderObject.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    height: 2,
                  ),
            ),
          ),
           SizedBox(
            height: AppSize.s60,
          ),
        ],
      ),
    );
  }
}

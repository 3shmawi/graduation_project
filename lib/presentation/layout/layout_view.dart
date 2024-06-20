import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LayoutVM>();
    return PopScope(
      canPop: false,
      onPopInvoked: (v) async {
        if (cubit.currentIndex != 0) {
          cubit.changeCurrentIndex(0);

          ctrl.animateToPage(
            0,
            duration: const Duration(
              milliseconds: AppConstants.durationAnimationDelay3,
            ),
            curve: Curves.easeIn,
          );
        } else {
          await SystemChannels.platform
              .invokeMethod<void>('SystemNavigator.pop', true);
        }
      },
      child: Scaffold(
        body: PageView.builder(
          onPageChanged: (n) {
            cubit.changeCurrentIndex(n);
          },
          scrollDirection: Axis.horizontal,
          controller: ctrl,
          itemBuilder: (context, index) => cubit.pages[index],
          itemCount: cubit.pages.length,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey2,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: (v) {
            cubit.changeCurrentIndex(v);
            ctrl.animateToPage(
              v,
              duration: const Duration(
                milliseconds: AppConstants.durationAnimationDelay3,
              ),
              curve: Curves.linear,
            );
          },
          items: [
            BottomNavigationBarItem(
              label: AppStrings.home.tr(),
              icon: SvgPicture.asset(
                AppAssets.home,
                colorFilter: ColorFilter.mode(
                  _isSelected(cubit.currentIndex, 0)
                      ? AppColors.primary
                      : AppColors.grey2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: AppStrings.campaign.tr(),
              icon: SvgPicture.asset(
                AppAssets.campaign,
                colorFilter: ColorFilter.mode(
                  _isSelected(cubit.currentIndex, 1)
                      ? AppColors.primary
                      : AppColors.grey2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: AppStrings.chat.tr(),
              icon: Lottie.asset(
                AppAssets.chat,
                height: AppHeight.h50,
              ),
            ),
            BottomNavigationBarItem(
              label: AppStrings.fields.tr(),
              icon: SvgPicture.asset(
                AppAssets.fields,
                colorFilter: ColorFilter.mode(
                  _isSelected(cubit.currentIndex, 3)
                      ? AppColors.primary
                      : AppColors.grey2,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: AppStrings.profile.tr(),
              icon: const Icon(Feather.user),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSelected(int index, int n) {
    return index == n;
  }
}

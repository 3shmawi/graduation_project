import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../services/notification_services.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  _initServices() async {
    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      await NotificationService()
          .initFirebasePushNotification(context)
          .then((value) => NotificationService().checkingPermission());
    });
  }

  @override
  void initState() {
    super.initState();
    _initServices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutVM, AppCubitStates>(
      builder: (context, state) {
        final cubit = context.watch<LayoutVM>();

        return PopScope(
          canPop: false,
          onPopInvoked: (v) async {
            if (cubit.currentIndex != 0) {
              cubit.changeCurrentIndex(0);
            } else {
              await SystemChannels.platform
                  .invokeMethod<void>('SystemNavigator.pop', true);
            }
          },
          child: Scaffold(
            body: PageView.builder(
              onPageChanged: (n) {
                // cubit.ctrl.animateToPage(
                //   n,
                //   duration: const Duration(
                //     milliseconds: AppConstants.durationAnimationDelay3,
                //   ),
                //   curve: Curves.easeIn,
                // );
              },
              scrollDirection: Axis.horizontal,
              controller: cubit.ctrl,
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
                if (v == 0) {
                  context.read<HomeCtrl>().getPosts3();
                }
                cubit.ctrl
                    .animateToPage(
                      v,
                      duration: const Duration(
                        milliseconds: AppConstants.durationAnimationDelay3,
                      ),
                      curve: Curves.easeIn,
                    )
                    .then((_) => cubit.changeCurrentIndex(v));
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
                  label: AppStrings.bookmarks.tr(),
                  icon: Icon(
                    _isSelected(cubit.currentIndex, 3)
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                    color: _isSelected(cubit.currentIndex, 3)
                        ? AppColors.primary
                        : AppColors.grey2,
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
      },
    );
  }

  bool _isSelected(int index, int n) {
    return index == n;
  }
}

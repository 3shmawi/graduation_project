import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final ctrl = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LayoutVM>();
    return Scaffold(
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
                milliseconds: AppConstants.duraitonAnimationDelay),
            curve: Curves.linear,
          );
        },
        items: [
          BottomNavigationBarItem(
            label: AppStrings.home,
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
            label: AppStrings.box,
            icon: SvgPicture.asset(
              AppAssets.box,
              colorFilter: ColorFilter.mode(
                _isSelected(cubit.currentIndex, 1)
                    ? AppColors.primary
                    : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.chat,
            icon: Lottie.asset(
              AppAssets.chat,
              height: AppSize.s50,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.fields,
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
            label: AppStrings.campaign,
            icon: SvgPicture.asset(
              AppAssets.campaign,
              colorFilter: ColorFilter.mode(
                _isSelected(cubit.currentIndex, 4)
                    ? AppColors.primary
                    : AppColors.grey2,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSelected(int index, int n) {
    return index == n;
  }
}

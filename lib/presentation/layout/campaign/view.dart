import 'package:donation/presentation/_resources/component/button.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/global_imports.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  final List<Test> current = [
    Test(
      'https://plus.unsplash.com/premium_photo-1682125773446-259ce64f9dd7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGVkdWNhdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
      'املأ حقيبة بالعلم والأمل',
      'حملة التبرع بالعدة المدرسية',
    ),
    Test(
      'https://images.unsplash.com/photo-1512678080530-7760d81faba6?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGhvc3BpdGFsfGVufDB8fDB8fHww',
      'ابنى الامل',
      'هذة الحملة تم تفعيلها لبناء الامل للمستشفيات فى جلب احدث اجهزة اشعة',
    ),
    Test(
      'https://images.unsplash.com/photo-1655720359248-eeace8c709c5?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nzh8fHNvbGlkYXJpdHl8ZW58MHx8MHx8fDA%3D',
      'لقاءات تغير حياة',
      'حملة كفالة اليتيم',
    ),
  ];

  List<String> categoriesLabel = [
    AppStrings.solidarity,
    AppStrings.health,
    AppStrings.education,
    AppStrings.development,
    AppStrings.diggingWell,
    AppStrings.algarmin,
  ];
  List<String> categoriesIcon = [
    AppAssets.solidarity,
    AppAssets.health,
    AppAssets.education,
    AppAssets.development,
    AppAssets.diggingWell,
    AppAssets.algarmin,
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              collapsedHeight: AppHeight.h108,
              expandedHeight: AppHeight.h100,
              flexibleSpace: Container(
                height: AppHeight.h226,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p35,
                  horizontal: AppPadding.p20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradient4,
                      AppColors.gradient5,
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.donationMess1,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: AppHeight.h4),
                        Text(
                          AppStrings.donationMess2,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: AppColors.white,
                        size: AppSize.s28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverAppBar(
              pinned: true,
              floating: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(
                    AppSize.s20,
                  ),
                ),
              ),
              foregroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              toolbarHeight: AppHeight.h110,
              titleSpacing: AppSize.s0,
              flexibleSpace: Stack(
                children: [
                  Container(
                    height: AppHeight.h92,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(AppSize.s20),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.gradient4,
                          AppColors.gradient5,
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(top: AppPadding.p35),
                    scrollDirection: Axis.horizontal,
                    child: AnimationLimiter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 500),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: List.generate(
                            categoriesIcon.length,
                            (index) => Item(
                              onTap: () {
                                currentIndex = index;
                                setState(() {});
                              },
                              isSelected: index == currentIndex,
                              icon: categoriesIcon[index],
                              label: categoriesLabel[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: AnimationLimiter(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(seconds: 1),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                HeadTitle(title: AppStrings.currentDonation),
                SizedBox(
                  height: AppHeight.h235,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CurrentDonationItem(
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.campaignDetailsRoute),
                      img: current[index].img,
                      title: current[index].title,
                      subTitle: current[index].subTitle,
                    ),
                    itemCount: current.length,
                  ),
                ),
                HeadTitle(
                  title: AppStrings.products,
                  width: AppWidth.w40,
                ),
                SizedBox(
                  height: AppHeight.h327,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProductItem(
                      title: current[index].title,
                      subTitle: current[index].subTitle,
                      balance: '400 جنية',
                      img: current[index].img,
                    ),
                    itemCount: current.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  final bool isSelected;
  final String icon;
  final String label;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidth.w60,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.black : AppColors.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Column(
          children: [
            icon.startsWith('http')
                ? CustomCacheImage(
                    imageUrl: icon,
                    radius: AppSize.s8,
                  )
                : SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.white : AppColors.grey,
                      BlendMode.srcIn,
                    ),
                    height: AppHeight.h40,
                    width: AppWidth.w40,
                  ),
            const Divider(),
            const Spacer(),
            Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: isSelected ? AppColors.white : AppColors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    required this.title,
    this.width = AppWidth.w110,
    super.key,
  });

  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20, vertical: AppPadding.p12),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppHeight.h4),
            Container(
              height: 2,
              width: width,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentDonationItem extends StatelessWidget {
  const CurrentDonationItem({
    required this.img,
    required this.title,
    required this.subTitle,
    this.onTap,
    super.key,
  });

  final String img;
  final String title;
  final String subTitle;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s12),
      splashColor: AppColors.white,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        width: AppWidth.w200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCacheImage(
              imageUrl: img,
              height: AppHeight.h128,
              radius: AppSize.s12,
            ),
            const SizedBox(height: AppHeight.h12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppHeight.h8),
            Expanded(
              child: Text(
                subTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.title,
    required this.subTitle,
    required this.balance,
    required this.img,
    super.key,
  });

  final String title;
  final String subTitle;
  final String balance;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      width: AppWidth.w200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCacheImage(
            imageUrl: img,
            radius: AppSize.s12,
            height: AppHeight.h100,
          ),
          const SizedBox(height: AppHeight.h12),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppHeight.h8),
          Expanded(
            child: Text(
              subTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12,
              vertical: AppPadding.p20,
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.ticket),
                const Spacer(),
                Text(
                  balance,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          CustomButton(
            label: AppStrings.donate,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class Test {
  String title;
  String subTitle;
  String img;

  Test(this.img, this.title, this.subTitle);
}

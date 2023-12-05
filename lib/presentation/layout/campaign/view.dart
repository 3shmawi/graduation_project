import 'package:donation/presentation/_resources/component/button.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
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
              collapsedHeight: AppSize.s100,
              expandedHeight: AppSize.s100,
              flexibleSpace: Container(
                height: AppSize.s226,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.donationMess1,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(
                          AppStrings.donationMess2,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAssets.notification,
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
              toolbarHeight: AppSize.s110,
              titleSpacing: AppSize.s0,
              flexibleSpace: Stack(
                children: [
                  Container(
                    height: AppSize.s92,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Item(
                          icon: AppAssets.solidarity,
                          label: AppStrings.solidarity,
                        ),
                        Item(
                          icon: AppAssets.health,
                          label: AppStrings.health,
                        ),
                        Item(
                          icon: AppAssets.education,
                          label: AppStrings.education,
                        ),
                        Item(
                          icon: AppAssets.development,
                          label: AppStrings.development,
                        ),
                        Item(
                          icon: AppAssets.diggingWell,
                          label: AppStrings.diggingWell,
                        ),
                        Item(
                          icon: AppAssets.algarmin,
                          label: AppStrings.algarmin,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            HeadTitle(title: AppStrings.currentDonation),
            SizedBox(
              height: AppSize.s235,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
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
              width: AppSize.s40,
            ),
            SizedBox(
              height: AppSize.s327,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
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
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    required this.icon,
    required this.label,
    super.key,
  });

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s60,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: const EdgeInsets.all(AppPadding.p8),
      margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Column(
        children: [
          icon.startsWith('http')
              ? CustomCacheImage(
                  imageUrl: icon,
                  radius: AppSize.s8,
                )
              : SvgPicture.asset(
                  icon,
                  height: AppSize.s40,
                  width: AppSize.s40,
                ),
          const Divider(),
          const Spacer(),
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class HeadTitle extends StatelessWidget {
  const HeadTitle({
    required this.title,
    this.width = AppSize.s110,
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
            const SizedBox(height: AppSize.s4),
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
        width: AppSize.s200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCacheImage(
              imageUrl: img,
              height: AppSize.s128,
              radius: AppSize.s12,
            ),
            const SizedBox(height: AppSize.s12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: FontSize.s20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppSize.s8),
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
      width: AppSize.s200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCacheImage(
            imageUrl: img,
            radius: AppSize.s12,
            height: AppSize.s100,
          ),
          const SizedBox(height: AppSize.s12),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSize.s8),
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

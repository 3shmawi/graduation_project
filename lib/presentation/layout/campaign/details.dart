import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_resources/component/button.dart';

class CampaignDetailsScreen extends StatefulWidget {
  const CampaignDetailsScreen({super.key});

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimationLimiter(
            child: ListView(
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
                  const CustomCacheImage(
                    imageUrl:
                        'https://plus.unsplash.com/premium_photo-1682125773446-259ce64f9dd7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGVkdWNhdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
                    radius: AppSize.s35,
                    topRight: false,
                    topLeft: false,
                    width: double.infinity,
                    height: AppHeight.h255,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeadLine(
                          label: 'بالتعليم استطيع : ',
                        ),
                        const SizedBox(height: AppHeight.h8),
                        Text(
                          'يوجد فى العالم 222 مليون طفل لم يلتحقوا بمقاعد التعليم بسبب الفقر ',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(height: AppHeight.h28),
                        const Divider(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              const HeadLine(
                                label:
                                    'املأ حقيبة بالعلم والأمل: حملة التبرع بالعدة المدرسية',
                              ),
                              Container(
                                height: AppHeight.h1_5,
                                width: 200,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                        HeadLine(
                          label: 'نبذة عن الحملة :',
                          color: AppColors.primary,
                        ),
                        Text(
                          'ندعوكم للمشاركة فى حملتنا الخيرية “ املا حقيبة بالعلم الامل “التى تهدف الى جمع العدة المدرسية للاطفال الذين يواجهون صعوبات فى الوصول الى المستلزمات المدرسية الاساسية لهذا العام سنقوم بتزيع حقائب مدرسية مجهزة لكل ما يحتاجة الاطفال لبداية دراسية ناجحة ',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(height: AppHeight.h35),
                        const Divider(),
                        const SizedBox(height: AppHeight.h16),
                        HeadLine(
                          label: 'كيف يمكنك المساهمة: ',
                          color: AppColors.primary,
                        ),
                        Text(
                          '1. التبرع المالي: يمكنك المساهمة بأي مبلغ تشاء، حيث سيتم استخدام تبرعك لشراء الجهاز وتطويره.',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(
                          height: AppHeight.h16,
                        ),
                        Text(
                          '2. نشر الحملة: ساعدنا في نشر هذه الحملة بين أصدقائك وعائلتك وشبكتك الاجتماعية. شاركها على وسائل التواصل وساهم في بناء جسر من الأمل.',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(
                          height: AppHeight.h20,
                        ),
                        const Divider(),
                        const HeadLine(label: 'الدول المشاركة فى الحملة :'),
                        const Align(
                          alignment: Alignment.center,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceAround,
                            children: [
                              CountryItem(
                                name: 'السعودية',
                                flag: 'flag',
                              ),
                              CountryItem(
                                name: 'السعودية',
                                flag: 'flag',
                              ),
                              CountryItem(
                                name: 'السعودية',
                                flag: 'flag',
                              ),
                              CountryItem(
                                name: 'السعودية',
                                flag: 'flag',
                              ),
                              CountryItem(
                                name: 'السعودية',
                                flag: 'flag',
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        SizedBox(
                          height: AppHeight.h92,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ItemBanner(
                                label: 'الايام المتبقية',
                                subTitle: '245 يوم',
                                icon: Feather.calendar,
                                color: AppColors.grey,
                              ),
                              const VertLine(),
                              ItemBanner(
                                label: 'المستفيدن',
                                subTitle: '100 شخص',
                                icon: Feather.users,
                                color: AppColors.primary,
                              ),
                              const VertLine(),
                              ItemBanner(
                                label: 'المبلغ المطلوب',
                                subTitle: '1,000,000 E.g',
                                icon: FontAwesome5Solid.coins,
                                color: AppColors.primaryOpacity70,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p28,
                            horizontal: AppPadding.p12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: CustomButton(
                                  label: 'منتجات الحملة',
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: AppWidth.w20),
                              Expanded(
                                flex: 4,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.black,
                                    elevation: 2,
                                    minimumSize: const Size(
                                        AppWidth.w327, AppHeight.h48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s12),
                                    ),
                                    backgroundColor: AppColors.white,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          AppPadding.p20,
                                          0,
                                          AppPadding.p8,
                                          0,
                                        ),
                                        child: Icon(
                                          FontAwesome.rocket,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Text(
                                        'التبرع السريع',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const DefaultAppBar()
        ],
      ),
    );
  }
}

class HeadLine extends StatelessWidget {
  const HeadLine({
    required this.label,
    this.color,
    this.size,
    super.key,
  });

  final String label;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      child: Text(
        label,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: size ?? FontSize.s18,
              color: color,
            ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.blue,
            size: AppSize.s28,
          ),
        ),
        const Spacer(),
        const ShareButton(),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p35,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.share,
            ),
            const SizedBox(height: AppHeight.h4),
            Text(
              'مشاركة',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class VertLine extends StatelessWidget {
  const VertLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m12, horizontal: AppMargin.m8),
      width: AppWidth.w1_5,
      color: AppColors.primary,
    );
  }
}

class ItemBanner extends StatelessWidget {
  const ItemBanner({
    required this.label,
    required this.subTitle,
    required this.color,
    required this.icon,
    super.key,
  });

  final String label;
  final Color color;
  final IconData icon;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const Spacer(),
              HeadLine(
                label: label,
                color: AppColors.primary,
                size: FontSize.s16,
              ),
            ],
          ),
          Text(
            subTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium,
          )
        ],
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  const CountryItem({
    required this.name,
    required this.flag,
    super.key,
  });

  final String flag;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppMargin.m8),
      height: AppHeight.h40,
      width: AppWidth.w128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        border: Border.all(
          color: AppColors.black,
          width: AppWidth.w1_5,
        ),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            radius: AppSize.s14,
            child: CustomCacheImage(
              imageUrl: flag,
              height: AppHeight.h28,
              width: AppWidth.w28,
              radius: AppSize.s100,
            ),
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}

import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
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
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const CustomCacheImage(
                imageUrl:
                    'https://plus.unsplash.com/premium_photo-1682125773446-259ce64f9dd7?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGVkdWNhdGlvbnxlbnwwfHwwfHx8MA%3D%3D',
                radius: AppSize.s35,
                circularShape: false,
                width: double.infinity,
                height: AppSize.s255,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadLine(
                      label: 'بالتعليم استطيع : ',
                    ),
                    const SizedBox(height: AppSize.s8),
                    Text(
                      'يوجد فى العالم 222 مليون طفل لم يلتحقوا بمقاعد التعليم بسبب الفقر ',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: FontSize.s16,
                          ),
                    ),
                    const SizedBox(height: AppSize.s28),
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
                            height: AppSize.s1_5,
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
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: FontSize.s16,
                          ),
                    ),
                    const SizedBox(height: AppSize.s35),
                    const Divider(),
                    const SizedBox(height: AppSize.s16),
                    HeadLine(
                      label: 'كيف يمكنك المساهمة: ',
                      color: AppColors.primary,
                    ),
                    Text(
                      '1. التبرع المالي: يمكنك المساهمة بأي مبلغ تشاء، حيث سيتم استخدام تبرعك لشراء الجهاز وتطويره.',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: FontSize.s16,
                          ),
                    ),
                    const SizedBox(
                      height: AppSize.s16,
                    ),
                    Text(
                      '2. نشر الحملة: ساعدنا في نشر هذه الحملة بين أصدقائك وعائلتك وشبكتك الاجتماعية. شاركها على وسائل التواصل وساهم في بناء جسر من الأمل.',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: FontSize.s16,
                          ),
                    ),
                    const SizedBox(
                      height: AppSize.s20,
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
                    const SizedBox(
                      height: AppSize.s92,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemBanner(
                            label: 'الايام المتبقية',
                            subTitle: '245 يوم',
                            icon: AppAssets.calender,
                          ),
                          VertLine(),
                          ItemBanner(
                            label: 'المستفيدن',
                            subTitle: '100 شخص',
                            icon: AppAssets.gender,
                          ),
                          VertLine(),
                          ItemBanner(
                            label: 'المبلغ المطلوب',
                            subTitle: '1,000,000 E.g',
                            icon: AppAssets.money,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSize.s28,
                        horizontal: AppSize.s12,
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
                          const SizedBox(width: AppSize.s20),
                          Expanded(
                            flex: 4,
                            child: CustomButton(
                              label: 'التبرع السريع',
                              onPressed: () {},
                              icon: AppAssets.fast,
                              color: AppColors.white,
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
              fontSize: size ?? FontSize.s20,
              color: color ?? AppColors.black,
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
            const SizedBox(height: AppSize.s4),
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
      width: AppSize.s1_5,
      color: AppColors.primary,
    );
  }
}

class ItemBanner extends StatelessWidget {
  const ItemBanner(
      {required this.label,
      required this.subTitle,
      required this.icon,
      super.key});

  final String label;
  final String icon;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  AppColors.grey2,
                  BlendMode.srcIn,
                ),
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
      height: AppSize.s40,
      width: AppSize.s128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        border: Border.all(
          color: AppColors.black,
          width: AppSize.s1_5,
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
              height: AppSize.s28,
              width: AppSize.s28,
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

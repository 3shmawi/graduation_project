import 'package:donation/app/api.dart';
import 'package:donation/app/functions.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/app/services.dart';
import 'package:donation/domain/model/campaign.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/model/messages.dart';
import '../../auth/auth_view_model.dart';
import '../chats/details.dart';

class CampaignDetailsScreen extends StatefulWidget {
  const CampaignDetailsScreen(this.campaign, {super.key});

  final Campaign campaign;

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
                  ImgCard2(widget.campaign.photosLink!),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadLine(
                          label: widget.campaign.title!,
                        ),
                        Text(
                          widget.campaign.titleDescription!,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(height: AppHeight.h12),
                        const Divider(),
                        Row(
                          children: [
                            HeadLine(
                              label: AppStrings.aboutCampaign,
                              color: AppColors.primary,
                            ),
                            const Spacer(),
                            Text(
                              "${AppStrings.publishedAt.tr()} ${daysBetween(
                                DateTime.parse(widget.campaign.createdAt!),
                              )}",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Text(
                          widget.campaign.aboutCampaign!,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ),
                        const SizedBox(height: AppHeight.h12),
                        const Divider(),
                        HeadLine(
                          label: AppStrings.howToContribute,
                          color: AppColors.primary,
                        ),
                        Text(
                          AppStrings.financialDonation,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ).tr(),
                        const SizedBox(
                          height: AppHeight.h16,
                        ),
                        Text(
                          AppStrings.campaignPromotion,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontSize: FontSize.s16,
                                  ),
                        ).tr(),
                        const SizedBox(
                          height: AppHeight.h20,
                        ),
                        const Divider(),
                        SizedBox(
                          height: AppHeight.h92,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ItemBanner(
                                label: AppStrings.requiredAmount,
                                subTitle:
                                    widget.campaign.totalAmount!.toString(),
                                icon: FontAwesome5Solid.coins,
                                color: AppColors.primaryOpacity70,
                              ),
                              const VertLine(),
                              ItemBanner(
                                label: AppStrings.remainingAmount,
                                subTitle:
                                    widget.campaign.remainingAmount!.toString(),
                                icon: FontAwesome5Solid.coins,
                                color: AppColors.primaryOpacity70,
                              ),
                              const VertLine(),
                              ItemBanner(
                                label: AppStrings.beneficiaries,
                                subTitle:
                                    widget.campaign.beneficiaries!.toString(),
                                icon: Feather.users,
                                color: AppColors.primary,
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
                                  onPressed: () {
                                    AppService.openLink(
                                      context,
                                      ApiUrl.paymentUrlPage(
                                          widget.campaign.id!),
                                    );
                                  },
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
                                        AppStrings.quickDonate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(color: AppColors.primary),
                                      ).tr(),
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
          DefaultAppBar(widget.campaign.userID!)
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
        label.tr(),
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: size ?? FontSize.s18,
              color: color,
            ),
      ),
    );
  }
}

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(this.userId, {super.key});

  final UserId userId;

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
        ShareButton(userId),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton(this.userId, {super.key});

  final UserId userId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = context.read<AuthCtrl>().userData;
        final sender = User(
          id: cubit!.id!,
          name: cubit.userName!,
          avatarUrl: cubit.photoLink,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatDetailPage(
              User(
                id: userId.id!,
                avatarUrl: userId.photoLink,
                name: userId.userName!,
              ),
              sender: sender,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p35,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(AppAssets.chat, height: 50),
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

class ImgCard2 extends StatefulWidget {
  const ImgCard2(this.images, {super.key});

  final List<String> images;

  @override
  State<ImgCard2> createState() => _ImgCard2State();
}

class _ImgCard2State extends State<ImgCard2> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomCacheImage(
          imageUrl: widget.images[currentIndex],
          radius: AppSize.s30,
          topRight: false,
          topLeft: false,
          height: 250,
          width: double.infinity,
        ),
        CircleAvatar(
          backgroundColor: Colors.white54,
          child: IconButton(
            onPressed: () {
              setState(() {});
              if (currentIndex == widget.images.length - 1) {
                currentIndex = 0;
              } else {
                currentIndex++;
              }
            },
            icon: Icon(
              CupertinoIcons.arrow_right_circle,
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }
}

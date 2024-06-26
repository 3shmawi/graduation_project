import 'package:donation/app/config.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:donation/presentation/_resources/component/empty_page.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/layout/campaign/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/functions.dart';
import '../../../app/global_imports.dart';
import '../../_resources/component/loading_card.dart';

class CampaignPage extends StatefulWidget {
  const CampaignPage({super.key});

  @override
  State<CampaignPage> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  int calculateCrossAxisCount(BuildContext context) {
    final screenWidth = Dimensions.screenWidth(context);

    if (screenWidth > 1200) {
      return 4;
    } else if (screenWidth > 768) {
      return 3;
    } else {
      return 2;
    }
  }

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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: AppSize.s14,
                          ),
                          Text(
                            AppStrings.donationMess1.tr(),
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppHeight.h4),
                          Text(
                            AppStrings.donationMess2.tr(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    if (context.read<AuthCtrl>().userData!.userType ==
                        "organization")
                      FloatingActionButton(
                        elevation: 0,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.createCampaign,
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.white,
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
                      child: BlocBuilder<CampaignsCtrl, CampaignsStates>(
                        builder: (context, state) {
                          final cubit = context.read<CampaignsCtrl>();
                          return Row(
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
                                AppConfigs.campaignCategories.length,
                                (index) => Item(
                                  onTap: () {
                                    cubit.changeFilterIndex(index);
                                  },
                                  isSelected: index == cubit.currentFilterIndex,
                                  icon: AppConfigs.campaignIcons[index],
                                  label: AppConfigs.campaignCategories[index],
                                ),
                              ),
                            ),
                          );
                        },
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
                Row(
                  children: [
                    const HeadTitle(title: AppStrings.currentDonation),
                    const Spacer(),
                    TextButton(
                      onPressed: context.read<CampaignsCtrl>().getCampaigns,
                      child: const Text(
                        "REFRESH",
                      ),
                    ),
                  ],
                ),
                BlocBuilder<CampaignsCtrl, CampaignsStates>(
                  buildWhen: (_, current) =>
                      current is GetCampaignsLoadingState ||
                      current is GetCampaignsLoadedState ||
                      current is GetCampaignsErrorState,
                  builder: (context, state) {
                    final cubit = context.read<CampaignsCtrl>();
                    if (state is GetCampaignsLoadingState) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p14,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateCrossAxisCount(context),
                          mainAxisSpacing:
                              Dimensions.heightPercentage(context, 1),
                          crossAxisSpacing:
                              Dimensions.widthPercentage(context, 1),
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return const LoadingCard(height: 300);
                        },
                        itemCount: 4,
                      );
                    }
                    if (state is GetCampaignsLoadedState) {
                      if (state.campaigns.isNotEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async => cubit.getCampaigns(),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p14,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: calculateCrossAxisCount(context),
                              mainAxisSpacing:
                                  Dimensions.heightPercentage(context, 1),
                              crossAxisSpacing:
                                  Dimensions.widthPercentage(context, 1),
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  CardItem(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        Routes.campaignDetailsRoute,
                                        arguments: state.campaigns[index],
                                      );
                                    },
                                    icon: state
                                        .campaigns[index].photosLink!.first,
                                    title: state.campaigns[index].title!,
                                  ),
                                  if (AuthCtrl.usrId ==
                                      state.campaigns[index].userID!.id!)
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: AppSize.s20,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: AppColors.white,
                                        ),
                                        onPressed: () {
                                          //alart sure
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Are you sure?",
                                                  style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                content: Text(
                                                  "You will not be able to recover this campaign!",
                                                  style: TextStyle(
                                                    color: AppColors.error,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: AppColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      cubit.deleteCampaigns(
                                                        state.campaigns[index],
                                                      );
                                                    },
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: AppColors.error,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                ],
                              );
                            },
                            itemCount: state.campaigns.length,
                          ),
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.only(top: 100.0),
                        child: EmptyPage(
                          icon: Icons.campaign,
                          message: "No campaign available",
                          message1: "______",
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: EmptyPage(
                        icon: Icons.campaign,
                        message: "An error happened",
                        message1: "REFRESH",
                        onPressed: cubit.getCampaigns,
                      ),
                    );
                  },
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
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isSelected ? AppColors.white : AppColors.grey,
                BlendMode.srcIn,
              ),
              height: AppHeight.h40,
              width: AppWidth.w40,
            ),
            const Divider(color: Colors.deepPurple),
            const Spacer(),
            Text(
              label.tr(),
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
            ).tr(),
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

class CardItem extends StatefulWidget {
  const CardItem({
    required this.icon,
    required this.title,
    this.onTap,
    super.key,
  });

  final GestureTapCallback? onTap;
  final String icon;
  final String title;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: -30, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
      child: Opacity(
        opacity: _animation.value,
        child: Transform.translate(
          offset: Offset(0, _animation2.value),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: widget.onTap,
            child: SizedBox(
              height: w / 1.5,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomCacheImage(
                      imageUrl: widget.icon,
                      height: w / 1.1,
                      width: double.infinity,
                      radius: 25,
                    ),
                    Container(
                      height: AppHeight.h35,
                      decoration: const BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

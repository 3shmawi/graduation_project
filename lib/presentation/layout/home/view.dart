import 'package:donation/app/functions.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/post_model.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/layout/home/global_view.dart';
import 'package:donation/presentation/layout/home/upload_post_view.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../app/config.dart';
import 'drawer/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//goxecix532@fna6.com محمد محروس
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final _tabCtrl;

  @override
  void initState() {
    _tabCtrl = TabController(length: 3, vsync: this);
    super.initState();

    Future.delayed(Duration.zero).then((v) {
      context.read<HomeCtrl>().initTacCtrl(_tabCtrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const DrawerMenu(),
        body: BlocBuilder<HomeCtrl, HomeStates>(
          buildWhen: (_, current) => current is HomeInitialTabState,
          builder: (context, state) {
            return SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: AppHeight.h50,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      elevation: AppSize.s0,
                      surfaceTintColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.searchRoute);
                          },
                          icon: const Icon(
                            Feather.search,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.norifications);
                          },
                          icon: const Icon(
                            Icons.notifications_none_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Feather.menu,
                          ),
                        ),
                      ],
                      title: Row(
                        children: [
                          Image.asset(
                            AppAssets.logo2,
                            height: AppHeight.h48,
                          ),
                          Text(AppConfigs.appName),
                        ],
                      ),
                    ),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: AppHeight.h60,
                      elevation: AppSize.s20,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                            AppSize.s16,
                          ),
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      surfaceTintColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      pinned: true,
                      floating: true,
                      snap: false,
                      bottom: TabBar(
                        controller: _tabCtrl,
                        labelStyle:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.labelSmall,
                        unselectedLabelColor: AppColors.grey,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                        ),
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Icon(AntDesign.home),
                                const SizedBox(width: AppWidth.w8),
                                Text(AppStrings.forU),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(Icons.public_outlined),
                                const SizedBox(width: AppWidth.w8),
                                Text(AppStrings.world),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Icon(Entypo.upload),
                                const SizedBox(width: AppWidth.w8),
                                Text(
                                  AppStrings.upload,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabCtrl,
                  children: const [
                    GlobalView(),
                    GlobalView(),
                    UploadPostPage(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SocialPostItem extends StatefulWidget {
  const SocialPostItem(this.data, {super.key});

  final Document data;

  @override
  SocialPostItemState createState() => SocialPostItemState();
}

class SocialPostItemState extends State<SocialPostItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  late final Document post;

  @override
  void initState() {
    super.initState();
    post = widget.data;
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

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: Card(
          margin: const EdgeInsets.only(
            bottom: AppPadding.p28,
          ),
          elevation: AppSize.s4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header (Profile image, name, time posted, more button)
              _profile(),
              const Divider(height: AppHeight.h0),
              // Content (Description, Expandable Section)
              // Image
              if (post.photosLink!.isNotEmpty)
                ImgCard(
                  post.photosLink!,
                ),
              ExpandedText(title: post.content ?? "Content"),

              // Buttons (Like, Share, Comment)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                child: Row(
                  children: [
                    Button(
                      onPressed: () {},
                      icon: Icons.favorite,
                      number: "2K",
                      color: AppColors.error,
                    ),
                    Button(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.comments);
                      },
                      icon: CupertinoIcons.chat_bubble_2_fill,
                      number: "22K",
                      color: AppColors.grey,
                    ),
                    Button(
                      onPressed: () {},
                      icon: Feather.share_2,
                      number: "",
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    elevation: AppSize.s1_5,
                    minimumSize: const Size(AppWidth.w255, AppHeight.h48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FlutterIcons.ios_paper_plane_ion,
                        color: AppColors.white,
                      ),
                      const SizedBox(width: AppWidth.w12),
                      Text(
                        AppStrings.showDetails,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _profile() => Directionality(
        textDirection: isStartWithArabic(post.userID!.userName!)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ListTile(
          leading: CircleAvatar(
            radius: AppSize.s25,
            backgroundImage: NetworkImage(
              post.userID!.photoLink!.isEmpty
                  ? AppConfigs.defaultImg
                  : post.userID!.photoLink!,
            ),
          ),
          title: Text(
            post.userID!.userName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontSize.s18,
                ),
          ), // User Name
          subtitle: Text(
            daysBetween(DateTime.parse(post.createdAt!)),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: FontSize.s12,
                ),
          ), // Time Posted
          trailing: post.userID!.id == AuthCtrl.usrId
              ? PopupMenuButton(
                  icon: Icon(
                    Feather.more_vertical,
                    color: AppColors.black,
                  ),
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        context.read<HomeCtrl>().tabCtrl.animateTo(2);
                      case 1:
                        context.read<HomeCtrl>().deletePost(post);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Text(
                          "Edit Post",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Delete Post",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ];
                  },
                )
              : null,
        ),
      );
}

class ExpandedText extends StatefulWidget {
  const ExpandedText({required this.title, super.key});

  final String title;

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  bool stateFade = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        stateFade = !stateFade;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p8,
          horizontal: AppPadding.p16,
        ),
        child: AnimatedCrossFade(
          firstChild: Text(
            widget.title,
            maxLines: 2,
            textDirection: isStartWithArabic(widget.title)
                ? TextDirection.rtl
                : TextDirection.ltr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  height: AppHeight.h1_5,
                  fontSize: FontSize.s16,
                ),
          ),
          secondChild: Text(
            widget.title,
            textDirection: isStartWithArabic(widget.title)
                ? TextDirection.rtl
                : TextDirection.ltr,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  height: AppHeight.h1_5,
                  fontSize: FontSize.s16,
                ),
          ),
          crossFadeState:
              stateFade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(
            milliseconds: AppConstants.durationAnimationDelay3,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    required this.icon,
    required this.number,
    required this.color,
    this.onPressed,
    super.key,
  });

  final String number;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.s8),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (number.isNotEmpty)
                Text(
                  number,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              if (number.isNotEmpty) const SizedBox(width: AppWidth.w8),
              Icon(
                icon,
                color: color,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImgCard extends StatefulWidget {
  const ImgCard(this.images, {super.key});

  final List<String> images;

  @override
  State<ImgCard> createState() => _ImgCardState();
}

class _ImgCardState extends State<ImgCard> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Stack(
        children: [
          CustomCacheImage(
            imageUrl: widget.images[currentIndex],
            radius: AppSize.s30,
            topRight: false,
            bottomLeft: false,
            height: AppHeight.h150,
            width: double.infinity,
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (currentIndex > 0) {
                    setState(() {
                      currentIndex--;
                    });
                  }
                },
                icon: const Icon(
                  CupertinoIcons.arrow_right_circle,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (currentIndex < widget.images.length - 1) {
                    setState(() {
                      currentIndex++;
                    });
                  }
                },
                icon: const Icon(
                  CupertinoIcons.arrow_left_circle,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

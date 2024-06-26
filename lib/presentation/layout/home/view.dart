import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/app/functions.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/likes.dart';
import 'package:donation/domain/model/messages.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/layout/bookmark/model/post.dart';
import 'package:donation/presentation/layout/home/global_view.dart';
import 'package:donation/presentation/layout/home/notifications/view_model.dart';
import 'package:donation/presentation/layout/home/upload_post_view.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../app/config.dart';
import '../../../domain/model/notification.dart';
import '../../../domain/model/post_model.dart';
import '../../_resources/component/cache_img.dart';
import '../chats/details.dart';
import 'drawer/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (v) => context.read<HomeCtrl>().initTacCtrl(
            TabController(length: 3, vsync: this),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCtrl, HomeStates>(
      buildWhen: (_, current) => current is HomeInitialTabState,
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            drawer: const DrawerMenu(),
            body: SafeArea(
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
                        StreamBuilder<bool>(
                          stream: HandleNotification().isNotificationOpened(),
                          builder: (context, snapshot) {
                            return Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(AuthCtrl.usrId)
                                        .set(
                                      {"opened": true},
                                      SetOptions(merge: true),
                                    );

                                    Navigator.of(context)
                                        .pushNamed(Routes.norifications);
                                  },
                                  icon: const Icon(
                                    Icons.notifications_none_outlined,
                                  ),
                                ),
                                if (snapshot.data != null)
                                  if (!snapshot.data!)
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: AppColors.primary,
                                      ),
                                    ),
                              ],
                            );
                          },
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
                        onTap: (v) {
                          context.read<HomeCtrl>().getPosts3();
                          context.read<HomeCtrl>().animateTo(v);
                        },
                        controller: context.read<HomeCtrl>().tabCtrl,
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
                  controller: context.read<HomeCtrl>().tabCtrl,
                  children: const [
                    GlobalView(),
                    GlobalView(),
                    UploadPostPage(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SocialPostItem extends StatefulWidget {
  const SocialPostItem(this.post, {this.isPost = true, super.key});

  final Document post;

  final bool isPost;

  @override
  SocialPostItemState createState() => SocialPostItemState();
}

class SocialPostItemState extends State<SocialPostItem>
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
              if (widget.post.photosLink!.isNotEmpty)
                ImgCard(
                  widget.post.photosLink!,
                ),
              ExpandedText(
                title: widget.post.content!,
              ),

              // Buttons (Like, Share, Comment)
              if (widget.isPost)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                  child: Row(
                    children: [
                      StreamBuilder<List<LikesModel>>(
                          stream: context
                              .read<HomeCtrl>()
                              .getPostLikes(widget.post.id!),
                          builder: (context, snapshot) {
                            final cubit = context.read<HomeCtrl>();
                            final usr = context.read<AuthCtrl>().userData!;
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              bool isLike = false;
                              final data = snapshot.data;
                              if (data != null) {
                                if (data.isNotEmpty) {
                                  for (var like in data) {
                                    if (like.id == AuthCtrl.usrId) {
                                      isLike = true;
                                      break;
                                    }
                                  }
                                }
                                return Button(
                                  onPressed: () {
                                    cubit.like(
                                      widget.post.id!,
                                      !isLike,
                                      usr.userName!,
                                      usr.photoLink!,
                                    );
                                    if (!isLike) {
                                      final createdAt =
                                          DateTime.now().toIso8601String();
                                      final sender =
                                          context.read<AuthCtrl>().userData!;
                                      HandleNotification().sendNotification(
                                        NotificationModel(
                                          id: createdAt,
                                          type: "like",
                                          title:
                                              "${sender.userName} has liked your post",
                                          createdAt: createdAt,
                                          from: User(
                                              id: sender.id!,
                                              name: sender.userName!,
                                              avatarUrl: sender.photoLink),
                                          to: User(
                                            id: widget.post.userID!.id!,
                                            name: widget.post.userID!.userName!,
                                            avatarUrl:
                                                widget.post.userID!.photoLink,
                                          ),
                                          postId: widget.post.id,
                                          isRead: false,
                                        ),
                                      );
                                    }
                                  },
                                  icon: isLike
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  number: getNumOfLikes(data.length.toString()),
                                  color: AppColors.error,
                                );
                              }
                              return Button(
                                onPressed: () {
                                  cubit.like(
                                    widget.post.id!,
                                    true,
                                    usr.userName!,
                                    usr.photoLink!,
                                  );

                                  final createdAt =
                                      DateTime.now().toIso8601String();
                                  final sender =
                                      context.read<AuthCtrl>().userData!;
                                  HandleNotification().sendNotification(
                                    NotificationModel(
                                      id: createdAt,
                                      type: "like",
                                      title:
                                          "${sender.userName} has liked your post",
                                      createdAt: createdAt,
                                      from: User(
                                          id: sender.id!,
                                          name: sender.userName!,
                                          avatarUrl: sender.photoLink),
                                      to: User(
                                        id: widget.post.userID!.id!,
                                        name: widget.post.userID!.userName!,
                                        avatarUrl:
                                            widget.post.userID!.photoLink,
                                      ),
                                      postId: widget.post.id,
                                      isRead: false,
                                    ),
                                  );
                                },
                                icon: Icons.favorite_outline,
                                number: "0",
                                color: AppColors.grey,
                              );
                            }
                            return Button(
                              onPressed: () {},
                              icon: Icons.favorite_outline,
                              number: "0",
                              color: AppColors.grey,
                            );
                          }),
                      Button(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            Routes.comment,
                            arguments: widget.post,
                          );
                        },
                        icon: CupertinoIcons.chat_bubble_2_fill,
                        number: "",
                        color: AppColors.grey,
                      ),
                      Button(
                        onPressed: () {},
                        number: "Category",
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              if (widget.post.userID!.id == AuthCtrl.usrId)
                const SizedBox(height: AppSize.s14),
              if (widget.post.userID!.id != AuthCtrl.usrId)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.white,
                            elevation: AppSize.s1_5,
                            minimumSize:
                                const Size(AppWidth.w255, AppHeight.h48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () {
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
                                    id: widget.post.userID!.id!,
                                    avatarUrl: widget.post.userID!.photoLink,
                                    name: widget.post.userID!.userName!,
                                  ),
                                  sender: sender,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            FlutterIcons.ios_paper_plane_ion,
                            color: AppColors.white,
                          ),
                          label: Text(
                            AppStrings.showDetails,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                      if (widget.isPost)
                        BlocBuilder<HomeCtrl, HomeStates>(
                          builder: (context, state) {
                            final cubit = context.read<HomeCtrl>();
                            return IconButton(
                              onPressed: () {
                                cubit.addPost(
                                  Post(
                                    postId: widget.post.id!,
                                    name: widget.post.userID!.userName!,
                                    image: widget.post.userID!.photoLink!,
                                    date:
                                        DateTime.parse(widget.post.createdAt!),
                                    content: widget.post.content!,
                                  ),
                                );
                              },
                              icon: Icon(
                                cubit.postIndex(widget.post.id!) != -1
                                    ? CupertinoIcons.bookmark_fill
                                    : CupertinoIcons.bookmark,
                                color: AppColors.primary,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _profile() => Directionality(
        textDirection: isStartWithArabic(widget.post.userID!.userName!)
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ListTile(
          leading: CircleAvatar(
            radius: AppSize.s25,
            backgroundImage: NetworkImage(
              widget.post.userID!.photoLink!.isEmpty
                  ? AppConfigs.defaultImg
                  : widget.post.userID!.photoLink!,
            ),
          ),
          title: Text(
            widget.post.userID!.userName!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontSize.s18,
                ),
          ), // User Name
          subtitle: Text(
            daysBetween(DateTime.parse(widget.post.createdAt!)),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: FontSize.s12,
                ),
          ), // Time Posted
          trailing: widget.post.userID!.id == AuthCtrl.usrId
              ? PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppColors.grey,
                  ),
                  onSelected: (value) {
                    final cubit = context.read<HomeCtrl>();
                    switch (value) {
                      case 1:
                        cubit.edit(post: widget.post);
                      case 2:
                        cubit.deletePost(widget.post);
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          "EDIT",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.primary,
                                  ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          "DELETE",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: Colors.red,
                                  ),
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
    this.icon,
    required this.number,
    required this.color,
    this.onPressed,
    super.key,
  });

  final String number;
  final IconData? icon;
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
              if (number.isNotEmpty && icon != null)
                const SizedBox(width: AppWidth.w8),
              if (icon != null)
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
      ),
    );
  }
}

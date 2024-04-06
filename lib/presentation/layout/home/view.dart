import 'package:donation/app/functions.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/component/cache_img.dart';
import 'package:donation/presentation/_resources/component/loading_card.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../app/config.dart';
import 'drawer/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
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
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: AppSize.s0,
                  surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
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
                        Navigator.of(context).pushNamed(Routes.norifications);
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
                  expandedHeight: AppHeight.h60,
                  elevation: AppSize.s20,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(
                        AppSize.s16,
                      ),
                    ),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                  pinned: true,
                  floating: true,
                  snap: false,
                  bottom: TabBar(
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
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p20,
                    right: AppPadding.p20,
                    left: AppPadding.p20,
                  ),
                  itemBuilder: (context, index) {
                    if (index != 0 && index % 5 == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppPadding.p20),
                        child: LoadingCard(height: height / 3.2),
                      );
                    }
                    return const SocialPostItem();
                  },
                  itemCount: 10,
                ),
                ListView.builder(
                  padding: const EdgeInsets.only(top: AppPadding.p20),
                  itemBuilder: (context, index) {
                    return const SocialPostItem();
                  },
                  itemCount: 10,
                ),
                Center(
                  child: Icon(
                    CupertinoIcons.add,
                    size: AppSize.s50,
                    color: AppColors.primary,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialPostItem extends StatefulWidget {
  const SocialPostItem({super.key});

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
  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

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
              _profile("Mohamed Ashmawi"),
              const Divider(height: AppHeight.h0),
              // Content (Description, Expandable Section)
              // Image
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: CustomCacheImage(
                  imageUrl: imageUrl,
                  radius: AppSize.s30,
                  topRight: false,
                  bottomLeft: false,
                  height: AppHeight.h150,
                  width: double.infinity,
                ),
              ),
              const ExpandedText(
                title:
                    "تطبيق تعاون للأعمال الخيرية هو تطبيق يهدف إلى تسهيل وتعزيز العمل الخيري وتحفيز التعاون فيما بين المتبرعين والمنظمات الخيرية. يتيح هذا التطبيق للأفراد والمؤسسات التواصل والمشاركة في مجال الأعمال الخيرية بطريقة مبسطة وفعّالة.",
              ),

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

  _profile(String name) => Directionality(
        textDirection:
            isStartWithArabic(name) ? TextDirection.rtl : TextDirection.ltr,
        child: ListTile(
          leading: CircleAvatar(
            radius: AppSize.s25,
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: FontSize.s18,
                ),
          ), // User Name
          subtitle: Text(
            '2 hours ago',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontSize: FontSize.s12,
                ),
          ), // Time Posted
          trailing: IconButton(
            icon: const Icon(Feather.more_vertical),
            onPressed: () {
              // Handle more button tap
            },
          ),
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

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/config.dart';
import 'package:donation/app/functions.dart';
import 'package:donation/domain/model/messages.dart';
import 'package:donation/presentation/_resources/component/empty_page.dart';
import 'package:donation/presentation/_resources/component/loading_card.dart';
import 'package:donation/presentation/layout/chats/view_model.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:donation/presentation/layout/layout_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/global_imports.dart';
import 'details.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero).then((v) {
      // context.read<ChatCtrl>().getChats();
    });
    _refresh();
  }

  late final Timer _timer;

  _refresh() {
    _timer = Timer.periodic(const Duration(minutes: 1), (t) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(AppStrings.chat).tr(),
      ),
      body: SafeArea(
        child: StreamBuilder<List<UsersChatModel>>(
          stream: context.read<ChatCtrl>().getAllUsers2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final data = snapshot.data;
              if (data != null) {
                if (data.isNotEmpty) {
                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: data.length,
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Item(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatDetailPage(data[index].receiver),
                                    ),
                                  );
                                },
                                isStartWithArabic: isStartWithArabic(
                                    data[index].receiver.name),
                                img: data[index].receiver.avatarUrl!.isEmpty
                                    ? AppConfigs.defaultImg
                                    : data[index].receiver.avatarUrl!,
                                name: data[index].receiver.name,
                                lastMessage: data[index].lastMessage,
                                date: data[index].updatedAt,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return EmptyPage(
                  icon: Entypo.chat,
                  message: AppStrings.noChatsFound,
                  message1: AppStrings.goToHomePage,
                  onPressed: () {
                    context
                        .read<LayoutVM>()
                        .ctrl
                        .animateToPage(
                          0,
                          duration: const Duration(
                            milliseconds: AppConstants.durationAnimationDelay3,
                          ),
                          curve: Curves.easeIn,
                        )
                        .then((_) {
                      context.read<LayoutVM>().changeCurrentIndex(0);

                      context.read<HomeCtrl>().animateTo(0);
                    });
                  },
                );
              }
              return EmptyPage(
                icon: Entypo.chat,
                message: AppStrings.noResults,
                message1: "_____",
                onPressed: () {},
              );
            }
            return AnimationLimiter(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15);
                },
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                itemBuilder: (context, index) {
                  return const LoadingCard(height: 100);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    required this.img,
    required this.name,
    required this.lastMessage,
    required this.date,
    this.isStartWithArabic = false,
    this.isOpened,
    this.onTap,
    super.key,
  });

  final String date;
  final String name;
  final String lastMessage;
  final String img;
  final bool isStartWithArabic;
  final GestureTapCallback? onTap;
  final bool? isOpened;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isOpened == null ? null : Colors.grey.shade400,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
        titleAlignment: ListTileTitleAlignment.center,
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                lastMessage,
                maxLines: isOpened == null ? 1 : 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: FontSize.s16),
              ),
            ),
            Text(
              daysBetween(DateTime.parse(date)),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        title: Text(name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: FontSize.s20)),
        leading: CircleAvatar(
          radius: AppSize.s40,
          backgroundColor: AppColors.grey,
          backgroundImage: CachedNetworkImageProvider(img),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.touch_app_outlined,
            color: AppColors.primary,
          ),
          onPressed: onTap,
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/functions.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(AppStrings.chat).tr()),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            itemBuilder: (context, index) {
              const item = 'محمد عشماوي';
              const imageUrl =
                  'https://plus.unsplash.com/premium_photo-1701713781709-966e8f4c5920?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8'; // Replace with your image URL

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
                            builder: (context) => const ChatDetailPage(),
                          ),
                        );
                      },
                      isStartWithArabic: isStartWithArabic(item),
                      img: imageUrl,
                      name: item,
                      lastMessage: 'أهلين',
                    ),
                  ),
                ),
              );
            },
          ),
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
    this.isStartWithArabic = false,
    this.onTap,
    super.key,
  });

  final String name;
  final String lastMessage;
  final String img;
  final bool isStartWithArabic;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: FontSize.s16),
              ),
            ),
            Text(
              "12:20",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        title: Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: FontSize.s20)
        ),
        leading: CircleAvatar(
          radius: AppSize.s40,
          backgroundColor: AppColors.grey,
          backgroundImage: CachedNetworkImageProvider(img),
        ),
        onTap: onTap,
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            Feather.more_vertical,
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/_resources/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../_resources/values_manager.dart';
class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late List<Notification> notifications;
  @override
  Widget build(BuildContext context) {
    const itemName = '3bdo 7abib';
    const imageUrl =
        'https://plus.unsplash.com/premium_photo-1701713781709-966e8f4c5920?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8'; // Replace with your image URL
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppStrings.notification).tr(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.searchRoute);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          itemBuilder: (context, index) {
            return Item(
              onTap: () {},
              img: imageUrl,
              name: itemName,
              notificationItem: ' there is new notifications !there is new notifications !there is new notifications !there is new notifications !',

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
    required this.notificationItem,
    this.onTap,
    super.key,
  });

  final String name;
  final String notificationItem;
  final String img;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      titleAlignment: ListTileTitleAlignment.center,
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              notificationItem,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: FontSize.s14),
            ),
          ),
          Text(
            "01:00",
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
      onTap: onTap,
    );
  }
}
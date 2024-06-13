import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../_resources/color_manager.dart';
import '../../../_resources/font_manager.dart';
import '../../../_resources/strings_manager.dart';
import '../../../_resources/values_manager.dart';

class Comment extends StatefulWidget {
  //late final int postId;
  const Comment({super.key});
  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  late List<Item> comments = [];

  final TextEditingController _commentController = TextEditingController();
  late String commentText;

  @override
  Widget build(BuildContext context) {
    const itemName = '3bdo 7abib';
    const imageUrl =
        'https://plus.unsplash.com/premium_photo-1701713781709-966e8f4c5920?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8'; // Replace with your image URL

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.comment).tr(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                //final comment = comments[index];
                return comments[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    onChanged: (text) {
                      commentText = text;
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                    onPressed: () {
                      if (commentText == '') {
                        return;
                      } else {
                        _commentController.clear();
                        comments.add(Item(
                            img: imageUrl,
                            name: itemName,
                            commentItem: commentText));
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle_outlined)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item({
    required this.img,
    required this.name,
    required this.commentItem,
    this.onTap,
    super.key,
  });

  final String name;
  final String commentItem;
  final String img;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      titleAlignment: ListTileTitleAlignment.center,
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            commentItem,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontSize: FontSize.s14),
          ),
          Row(
            children: [
              Text(
                "01:00",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'like',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontSize: FontSize.s14),
                  )),
            ],
          )
        ],
      ),
      title: Text(name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: FontSize.s16)),
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
    );
  }
}

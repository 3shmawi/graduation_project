import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../app/functions.dart';
import '../../../_resources/values_manager.dart';

class CommentView extends StatefulWidget {
  const CommentView({super.key});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView>
    with SingleTickerProviderStateMixin {
  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header (Profile image, name, time posted, more button)
                _profile("3bdulrahman 7abib"),
                const Divider(
                  height: AppHeight.h0,
                  color: Colors.grey,
                ),
                // Content (Description, Expandable Section)
              ],
            );
          }),
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
          ), // User Name
          subtitle: const Text(
            'comment!',
          ), // Time Posted
          trailing: IconButton(
            icon: const Icon(Feather.heart),
            onPressed: () {
              // Handle more button tap
            },
          ),
        ),
      );
}

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/global_imports.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              AppSize.s8,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.black,
        elevation: 0,
        shadowColor: Colors.white10,
        title: Text(
          AppStrings.chat,
          style: Theme.of(context).textTheme.displayLarge,
        ),
        centerTitle: false,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 10, // Replace with your actual chat list length
          itemBuilder: (context, index) {
            final item = 'Chat Item $index';
            const imageUrl =
                'https://plus.unsplash.com/premium_photo-1701713781709-966e8f4c5920?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8'; // Replace with your image URL

            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildChatItem(item, imageUrl),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatItem(String item, String imageUrl) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          isThreeLine: true,
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
          titleAlignment: ListTileTitleAlignment.center,
          title: Text(item),
          subtitle: const Text('Subtitle'),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
          ),
          onTap: () {
            // Handle chat item tap
          },
        ),
      ),
    );
  }
}

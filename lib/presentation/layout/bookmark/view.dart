import 'package:donation/app/config.dart';
import 'package:donation/presentation/layout/home/view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/api.dart';
import '../../../app/functions.dart';
import '../../../app/global_imports.dart';
import '../../../domain/model/post_model.dart';
import '../../../services/dio_helper.dart';
import '../../_resources/component/empty_page.dart';
import '../../_resources/component/loading_card.dart';
import '../chats/view.dart';
import '../home/view.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({this.isFromNavigation = false, super.key});

  final bool isFromNavigation;

  @override
  BookMarkPageState createState() => BookMarkPageState();
}

class BookMarkPageState extends State<BookMarkPage> {
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: widget.isFromNavigation
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          title: const Text(AppStrings.bookmarks).tr()),
      body: BlocBuilder<HomeCtrl, HomeStates>(
        builder: (context, state) {
          final posts = context.read<HomeCtrl>().postBox.values;
          if (posts.isNotEmpty) {
            return SafeArea(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: posts.length,
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
                              _showBottomSheet(
                                  context, posts.elementAt(index).postId);
                            },
                            isStartWithArabic:
                                isStartWithArabic(posts.elementAt(index).name),
                            img: posts.elementAt(index).image.isEmpty
                                ? AppConfigs.defaultImg
                                : posts.elementAt(index).image,
                            name: posts.elementAt(index).name,
                            lastMessage: posts.elementAt(index).content,
                            date: posts.elementAt(index).date.toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const EmptyPage(
            icon: CupertinoIcons.bookmark,
            message: "No Book mark yet!",
            message1: "add a bookmark",
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.sizeOf(context).height * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Text(
                    AppStrings.bookmarks.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Divider(
                color: AppColors.primary,
                height: 5,
              ),
              const SizedBox(height: AppSize.s25),
              FutureBuilder<Document>(
                  future: _getCommentOrPost(postId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return SocialPostItem(
                          snapshot.data,
                        );
                      } else {
                        return const EmptyPage(
                          icon: Icons.error_outline,
                          message: "An Error happened",
                          message1: "try again later",
                        );
                      }
                    }
                    return const LoadingCard(height: 200);
                  }),
            ],
          ),
        );
      },
    );
  }

  Future<Document> _getCommentOrPost(String postId) async {
    final _http = HttpUtil();
    final response = await _http.get(ApiUrl.getPosts + postId);
    return Document.fromJson(response["data"]["document"]);
  }
}

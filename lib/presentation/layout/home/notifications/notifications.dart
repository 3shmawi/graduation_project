import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/config.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/notification.dart';
import 'package:donation/domain/model/post_model.dart';
import 'package:donation/presentation/layout/home/notifications/view_model.dart';
import 'package:donation/presentation/layout/home/view.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../app/functions.dart';
import '../../../_resources/component/empty_page.dart';
import '../../../_resources/component/loading_card.dart';
import '../../chats/details.dart';
import '../../chats/view.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(AppStrings.notification).tr(),
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: HandleNotification().getNotifications(),
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
                              isOpened: data[index].isRead,
                              onTap: () {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(data[index].to!.id)
                                    .collection("notifications")
                                    .doc(data[index].id)
                                    .update({"isRead": true});
                                if (data[index].type == "message") {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatDetailPage(data[index].from!),
                                    ),
                                  );
                                } else if (data[index].type == "like") {
                                  _showBottomSheet(context, data[index].postId,
                                      data[index].commentId);
                                } else {
                                  _showBottomSheet(context, data[index].postId,
                                      data[index].commentId);
                                }
                              },
                              isStartWithArabic:
                                  isStartWithArabic(data[index].from!.name),
                              img: data[index].from!.avatarUrl!.isEmpty
                                  ? AppConfigs.defaultImg
                                  : data[index].from!.avatarUrl!,
                              name: data[index].from!.name,
                              lastMessage: data[index].title,
                              date: data[index].createdAt,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const EmptyPage(
                icon: Entypo.notification,
                message: AppStrings.noNotificationDesc,
                message1: "......",
              );
            }
            return const EmptyPage(
              icon: Entypo.notification,
              message: AppStrings.noResults,
              message1: AppStrings.tryAgainLater,
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
    );
  }

  void _showBottomSheet(
      BuildContext context, String? postId, String? commentId) {
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
                    'Notification Detail',
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
                  future: _getCommentOrPost(postId, commentId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return SocialPostItem(
                          snapshot.data,
                          isPost: postId != null,
                        );
                      } else {
                        return const EmptyPage(
                          icon: Icons.error_outline,
                          message: AppStrings.noResults,
                          message1: AppStrings.tryAgainLater,
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

  Future<Document> _getCommentOrPost(String? postId, String? commentId) async {
    final http = HttpUtil();
    if (postId != null) {
      final response = await http.get(ApiUrl.getPosts + postId);
      return Document.fromJson(response["data"]["document"]);
    } else {
      final response = await http.get(ApiUrl.getComments + commentId!);
      return Document.fromJson(response["data"]["document"]);
    }
  }
}

import 'dart:io';

import 'package:donation/domain/model/post_model.dart';
import 'package:donation/presentation/layout/home/comments/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../app/global_imports.dart';
import '../../../_resources/component/empty_page.dart';
import '../../../_resources/component/loading_card.dart';
import '../../../_resources/component/toast.dart';
import '../../../auth/auth_view_model.dart';
import '../../../auth/widgets.dart';
import '../view.dart';

class CommentsView extends StatefulWidget {
  final Document post;

  const CommentsView(this.post, {super.key});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (_) => context.read<CommentsCtrl>().getComments(widget.post.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(AppStrings.comment),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<CommentsCtrl>().getComments(widget.post.id),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CommentsCtrl, CommentsStates>(
                buildWhen: (_, current) =>
                    current is GetCommentsLoadingState ||
                    current is GetCommentsLoadedState ||
                    current is GetCommentsErrorState,
                builder: (context, state) {
                  if (state is GetCommentsLoadingState) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p20,
                        right: AppPadding.p20,
                        left: AppPadding.p20,
                      ),
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: AppPadding.p20),
                          child: LoadingCard(height: AppSize.s200),
                        );
                      },
                      itemCount: 5,
                    );
                  }
                  if (state is GetCommentsLoadedState) {
                    if (state.comments.isEmpty) {
                      return const EmptyPage(
                        icon: FontAwesome.comments,
                        message: AppStrings.noCommentsFound,
                        message1: AppStrings.addOne,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        top: AppPadding.p20,
                        right: AppPadding.p20,
                        left: AppPadding.p20,
                      ),
                      itemBuilder: (context, index) {
                        return SocialPostItem(
                          state.comments[index],
                          isPost: false,
                        );
                      },
                      itemCount: state.comments.length,
                    );
                  }
                  return EmptyPage(
                    icon: EvilIcons.comment,
                    message: AppStrings.noResults,
                    message1: AppStrings.refresh,
                    onPressed: () async {
                      context.read<CommentsCtrl>().getComments(widget.post.id);
                    },
                  );
                },
              ),
            ),
            BlocBuilder<CommentsCtrl, CommentsStates>(
              builder: (context, state) {
                final cubit = context.read<CommentsCtrl>();
                return Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSize.s8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (cubit.images.isNotEmpty)
                        SizedBox(
                          height: AppSize.s150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final image = cubit.images;
                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image.file(
                                  File(image[index].path),
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: AppSize.s8);
                            },
                            itemCount: cubit.images.length,
                          ),
                        ),
                      if (state is CreateCommentsLoadingState)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: LinearProgressIndicator(),
                        ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (context
                                  .read<CommentsCtrl>()
                                  .contentCtrl
                                  .text
                                  .isEmpty) {
                                ShowToast.error(AppStrings.writeSomething);
                              } else {
                                final sender =
                                    context.read<AuthCtrl>().userData!;
                                context
                                    .read<CommentsCtrl>()
                                    .createComment(widget.post, sender);
                              }
                            },
                            splashColor: AppColors.primary,
                            icon: Icon(Feather.send, color: AppColors.primary),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<CommentsCtrl>().pickImages();
                            },
                            splashColor: AppColors.primary,
                            icon: Icon(Feather.image, color: AppColors.primary),
                          ),
                          Expanded(
                            child: AuthFormField(
                              controller:
                                  context.read<CommentsCtrl>().contentCtrl,
                              hintTxt: AppStrings.writeSomething,
                              prefixIcon: CupertinoIcons.chat_bubble_text_fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

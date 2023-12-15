import 'package:donation/app/functions.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../app/global_imports.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isKeyboardActive = false;

  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

  _goBottom() => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goBottom();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(
            width: AppWidth.w14,
          ),
          Row(
            children: [
              Text(
                'Mohamed Ashmawi',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: AppSize.s18,
                      height: 1.1,
                    ),
              ),
              const SizedBox(
                width: AppWidth.w8,
              ),
              CircleAvatar(
                radius: AppSize.s20,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ],
          ),
          const SizedBox(
            width: AppWidth.w14,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: AppPadding.p14),
              shrinkWrap: true,
              children: const [
                RightMessage(
                    "hello i'm mohamed ashmawi wow com sdfkj oijf how are you sir "),
                LeftMessage("hi jlsk lskjf lksf lkjlsd lskjdfl lksjf"),
                RightMessage("hello"),
                LeftMessage("hi"),
                RightMessage("hello"),
                RightMessage(
                    "hello i'm mohamed ashmawi wow com sdfkj oijf how are you sir "),
                LeftMessage("محمد عبدالفتاح عشماوي\nتمام "),
                LeftMessage("hi"),
                RightMessage(
                    "hello i'm mohamed ashmawi wow com sdfkj oijf how are you sir "),
                LeftMessage("hi jlsk lskjf lksf lkjlsd lskjdfl lksjf"),
                RightMessage("hello"),
                LeftMessage("hi"),
                RightMessage("hello"),
                RightMessage(
                    "hello i'm mohamed ashmawi wow com sdfkj oijf how are you sir "),
                LeftMessage("محمد عبدالفتاح عشماوي\nتمام "),
                LeftMessage("hi"),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: AppHeight.h60,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  AppSize.s8,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    _goBottom();
                    _textEditingController.clear();
                  },
                  splashColor: AppColors.primary,
                  icon: Icon(
                    Feather.send,
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: AuthFormField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    onTap: () {
                      Future.delayed(
                        const Duration(
                          milliseconds: 600,
                        ),
                      ).then((value) {
                        _goBottom();
                      });
                    },
                    hintTxt: AppStrings.writeSomething,
                    prefixIcon: CupertinoIcons.chat_bubble_text_fill,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RightMessage extends StatelessWidget {
  const RightMessage(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p0,
                AppPadding.p14,
                AppPadding.p14,
                AppPadding.p0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      message,
                      textAlign: isStartWithArabic(message)
                          ? TextAlign.start
                          : TextAlign.end,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    "1د",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class LeftMessage extends StatelessWidget {
  const LeftMessage(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppPadding.p14,
                AppPadding.p14,
                AppPadding.p0,
                AppPadding.p0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      message,
                      textAlign: isStartWithArabic(message)
                          ? TextAlign.start
                          : TextAlign.end,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Text(
                    "7m",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

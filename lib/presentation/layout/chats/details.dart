import 'dart:async';

import 'package:donation/app/functions.dart';
import 'package:donation/domain/model/messages.dart';
import 'package:donation/domain/model/notification.dart';
import 'package:donation/presentation/_resources/component/empty_page.dart';
import 'package:donation/presentation/_resources/component/loading_card.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:donation/presentation/layout/chats/view_model.dart';
import 'package:donation/presentation/layout/home/notifications/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../app/global_imports.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage(this.receiver, {this.sender, super.key});

  final User receiver;
  final User? sender;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isKeyboardActive = false;
  late IO.Socket socket;
  final imageUrl =
      'https://images.unsplash.com/photo-1701906268416-b461ec4caa34?w=700&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D'; // Replace with your image URL

  @override
  void initState() {
    print('1;1;;1;1;1;1');
    super.initState();
    _initializeSocket();
    _fetchMessages();
    _refresh();
  }

  late final Timer _timer;

  _refresh() {
    _timer = Timer.periodic(const Duration(minutes: 1), (t) => setState(() {}));
  }

  void _initializeSocket() {
    // socket = IO.io('https://social-api-trlr.onrender.com', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': false,
    //   'query': {'userId': AuthCtrl.usrId}, // Replace with the actual user ID
    // });
    //
    // socket.connect();
    // socket.on('connection', (_) => print('Connected'));
    // socket.on('disconnect', (_) => print('Disconnected'));
    // socket.on(
    //     'newMessage', (data) => context.read<ChatCtrl>().addMessage(data));
    // socket.on('getOnlineUsers', (data) => print('Online Users: $data'));
  }

  void _fetchMessages() {
    Future.delayed(Duration.zero).then((_) {
      // context.read<ChatCtrl>().getMessages(widget.receiverId);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // socket.disconnect();
    // socket.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _goBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCtrl, ChatStates>(
      listener: (context, state) {
        if (state is UserChatLoadedState && state.usrChats.isNotEmpty) {
          Future.delayed(const Duration(seconds: 1)).then((_) => _goBottom());
        }
      },
      buildWhen: (_, current) =>
          current is UserChatLoadedState || current is UserChatLoadingState,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                // context
                //     .read<ChatCtrl>()
                //     .txtCtrl
                //     .clear();
                // context.read<ChatCtrl>().getChats();
                Navigator.pop(context);
              },
            ),
            actions: [
              const SizedBox(width: AppWidth.w14),
              Row(
                children: [
                  Text(
                    widget.receiver.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: AppSize.s18,
                          height: 1.1,
                        ),
                  ),
                  const SizedBox(width: AppWidth.w8),
                  CircleAvatar(
                    radius: AppSize.s20,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ],
              ),
              const SizedBox(width: AppWidth.w14),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                      stream:
                          context.read<ChatCtrl>().getChats(widget.receiver.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final data = snapshot.data;
                          if (data != null) {
                            if (data.isNotEmpty) {
                              return ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (data[index].senderId == AuthCtrl.usrId) {
                                    return RightMessage(
                                      data[index].message,
                                      DateTime.parse(data[index].createdAt),
                                    );
                                  }
                                  return LeftMessage(
                                    data[index].message,
                                    DateTime.parse(data[index].createdAt),
                                  );
                                },
                                itemCount: data.length,
                              );
                            }
                            return Align(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: const Center(
                                  child: EmptyPage(
                                    icon: Entypo.chat,
                                    message: "No messages yet!",
                                    message1: "Start on",
                                  ),
                                ),
                              ),
                            );
                          }
                          return Align(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: const Center(
                                child: EmptyPage(
                                  icon: Entypo.chat,
                                  message: "An Error happened",
                                  message1: "try again later!",
                                ),
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          controller: _scrollController,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            if (index % 2 == 0) {
                              return const Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 150,
                                  child: LoadingCard(
                                    height: 50,
                                  ),
                                ),
                              );
                            }
                            return const Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 150,
                                child: LoadingCard(
                                  height: 50,
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                        );
                      })),
              _buildMessageInput(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final cubit = context.read<ChatCtrl>();
    return Container(
      width: double.infinity,
      height: AppHeight.h60,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSize.s8),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              if (cubit.txtCtrl.text.isEmpty) {
                ShowToast.error("write a message");
              } else {
                // socket.emit("newMessage", cubit.txtCtrl.text);
                await cubit.sendMessage(
                  receiver: widget.receiver,
                  isStartChat: widget.sender != null,
                  sender: widget.sender,
                );
                _goBottom();
                final createdAt = DateTime.now().toIso8601String();
                final sender = context.read<AuthCtrl>().userData!;
                HandleNotification().sendNotification(
                  NotificationModel(
                    id: createdAt,
                    type: "message",
                    title: "${sender.userName} Has sent a new message",
                    createdAt: createdAt,
                    from: User(
                        id: sender.id!,
                        name: sender.userName!,
                        avatarUrl: sender.photoLink),
                    to: User(
                        id: widget.receiver.id,
                        name: widget.receiver.name,
                        avatarUrl: widget.receiver.avatarUrl),
                    isRead: false,
                  ),
                );
              }
            },
            splashColor: AppColors.primary,
            icon: Icon(Feather.send, color: AppColors.primary),
          ),
          Expanded(
            child: AuthFormField(
              controller: cubit.txtCtrl,
              focusNode: _focusNode,
              onTap: () {
                Future.delayed(const Duration(milliseconds: 600))
                    .then((_) => _goBottom());
              },
              hintTxt: AppStrings.writeSomething,
              prefixIcon: CupertinoIcons.chat_bubble_text_fill,
            ),
          ),
        ],
      ),
    );
  }
}

class RightMessage extends StatelessWidget {
  const RightMessage(this.message, this.time, {super.key});

  final String message;
  final DateTime time;

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
                    daysBetween(time),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}

class LeftMessage extends StatelessWidget {
  const LeftMessage(this.message, this.time, {super.key});

  final String message;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: SizedBox()),
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
                      color: AppColors.grey.withOpacity(.3),
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
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.primary,
                              ),
                    ),
                  ),
                  Text(
                    daysBetween(time),
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

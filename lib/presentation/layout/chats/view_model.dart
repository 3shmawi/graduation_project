import 'package:donation/app/api.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:donation/services/socket_io.dart';

import '../../../domain/model/chat.dart';

class ChatCtrl extends Cubit<ChatStates> {
  ChatCtrl() : super(InitialChatState());

  final _http = HttpUtil();
  final txtCtrl = TextEditingController();
  List<Message> _chats = [];

  void getChats(String senderId) {
    emit(ChatLoadingState());
    _chats = [];
    _http.get(ApiUrl.getChats + senderId).then((value) {
      final data = value as List;
      _chats = data.map((json) => Message.fromJson(json)).toList();
      emit(ChatLoadedState(_chats));
    }).catchError((error) {
      print(error);
      emit(ChatErrorState());
    });
  }

  void addMessage(Message message) {
    _chats.add(message);
    emit(ChatLoadedState(_chats));
  }

  void sendMessage(String senderId) {
    SocketIOManager.sendMessage(txtCtrl.text);
    _http.post(
      ApiUrl.sendChat + senderId,
      data: {
        "message": txtCtrl.text,
      },
    ).then((v) {
      txtCtrl.clear();
    });
  }
}

abstract class ChatStates {}

final class InitialChatState extends ChatStates {}

final class ChatLoadingState extends ChatStates {}

final class ChatLoadedState extends ChatStates {
  ChatLoadedState(this._chats);

  final List<Message> _chats;

  List<Message> get chats => _chats;
}

final class ChatErrorState extends ChatStates {}

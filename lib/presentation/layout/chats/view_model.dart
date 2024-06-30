import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';

import '../../../domain/model/chat.dart';
import '../../../domain/model/messages.dart';

//firypowe@teleg.eu
class ChatCtrl extends Cubit<ChatStates> {
  ChatCtrl() : super(InitialChatState());

  final txtCtrl = TextEditingController();

  final _fireStore = FirebaseFirestore.instance;

  Stream<List<UsersChatModel>> getAllUsers2() {
    return _fireStore
        .collection('users')
        .doc(AuthCtrl.usrId)
        .collection("chats")
        .orderBy("updated_at", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return UsersChatModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<MessageModel>> getChats(String receiverId) {
    return _fireStore
        .collection('users')
        .doc(AuthCtrl.usrId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("created_at", descending: false)
        .orderBy(FieldPath.documentId, descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return MessageModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> sendMessage(
      {bool isStartChat = false, required User receiver, User? sender}) async {
    String createdAt = DateTime.now().toIso8601String();

    try {
      final message = MessageModel(
        id: createdAt,
        message: txtCtrl.text,
        createdAt: createdAt,
        senderId: AuthCtrl.usrId!,
      );

      final batch = _fireStore.batch();

      if (isStartChat && sender != null) {
        startChat(receiver, sender, createdAt);
      }

      // Add message to the sender's chat
      final senderChatRef = _fireStore
          .collection('users')
          .doc(AuthCtrl.usrId)
          .collection('chats')
          .doc(receiver.id)
          .collection('messages')
          .doc(createdAt);
      batch.set(senderChatRef, message.toJson());

      // Add message to the receiver's chat
      final receiverChatRef = _fireStore
          .collection('users')
          .doc(receiver.id)
          .collection('chats')
          .doc(AuthCtrl.usrId)
          .collection('messages')
          .doc(createdAt);
      batch.set(receiverChatRef, message.toJson());

      // Update last message for both users
      final lastMessageUpdate = {
        'last_message': txtCtrl.text,
        'updated_at': createdAt,
      };
      final senderChatMetaRef = _fireStore
          .collection('users')
          .doc(AuthCtrl.usrId)
          .collection('chats')
          .doc(receiver.id);
      batch.update(senderChatMetaRef, lastMessageUpdate);

      final receiverChatMetaRef = _fireStore
          .collection('users')
          .doc(receiver.id)
          .collection('chats')
          .doc(AuthCtrl.usrId);
      batch.update(receiverChatMetaRef, lastMessageUpdate);

      // Commit the batch
      await batch.commit();
      txtCtrl.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void startChat(User receiver, User sender, String createdAt) async {
    try {
      final batch = _fireStore.batch();

      final chatModelForSender = UsersChatModel(
        id: createdAt,
        receiver: receiver,
        lastMessage: '.....',
        updatedAt: createdAt,
      );

      final chatModelForReceiver = UsersChatModel(
        id: createdAt,
        receiver: sender,
        lastMessage: '.....',
        updatedAt: createdAt,
      );

      // Set chat metadata for the sender
      final senderChatMetaRef = _fireStore
          .collection('users')
          .doc(AuthCtrl.usrId)
          .collection('chats')
          .doc(receiver.id);
      batch.set(senderChatMetaRef, chatModelForSender.toJson());

      // Set chat metadata for the receiver
      final receiverChatMetaRef = _fireStore
          .collection('users')
          .doc(receiver.id)
          .collection('chats')
          .doc(AuthCtrl.usrId);
      batch.set(receiverChatMetaRef, chatModelForReceiver.toJson());

      // Commit the batch
      await batch.commit();
    } catch (e) {
      print('Error starting chat: $e');
    }
  }
}

abstract class ChatStates {}

final class InitialChatState extends ChatStates {}

final class ChatLoadingState extends ChatStates {}

final class ChatLoadedState extends ChatStates {}

final class ChatErrorState extends ChatStates {}

final class UserChatLoadingState extends ChatStates {}

final class UserChatLoadedState extends ChatStates {
  final List<Messages> usrChats;

  UserChatLoadedState(this.usrChats);
}

final class SendMessage extends ChatStates {}

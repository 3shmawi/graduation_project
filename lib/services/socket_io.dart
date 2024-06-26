import 'dart:async';

import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../app/api.dart';

class SocketIOManager {
  static IO.Socket? _socket;

  // Connect to the socket server
  static Future<void> connect() async {
    try {
      _socket = IO.io(ApiUrl.baseUrl, <String, dynamic>{
        'transports': ['websocket'],
      });
      _socket!.connect();

      _socket!.on('connect', (_) => ShowToast.info("Connected"));
      _socket!.onConnectError((e) => ShowToast.error(e.toString()));
      _socket!.on('message', _handleIncomingMessage);
    } catch (error) {
      print("Socket connection error: $error");
    }
  }

  // Disconnect from the _socket server
  static void disconnect() {
    if (_socket != null) _socket!.disconnect();
  }

  // Emit a message to the server
  static void sendMessage(String message) {
    if (_socket != null) {
      _socket!.emit('message', message);
      ShowToast.info("New message $message");
    }
  }

  // Handle incoming messages from the server
  static void _handleIncomingMessage(dynamic data) {
    ShowToast.info(data.toString());
    // Parse the data as a map
    Map<String, dynamic> messageMap = data as Map<String, dynamic>;

    // Extract message details (assuming the structure matches your response example)
    String senderId = messageMap['senderId']['_id'];
    String message = messageMap['message'];

    // Handle the message (e.g., display it in the chat UI)
    print("Received message: $message from $senderId");
  }
}

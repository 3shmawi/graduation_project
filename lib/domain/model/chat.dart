class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      senderId: json['senderId']['_id'],
      receiverId: json['receiverId']['_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

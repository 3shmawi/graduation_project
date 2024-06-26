class User {
  final String id;
  final String name;
  final String? avatarUrl;

  User({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        avatarUrl: json['avatar_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar_url': avatarUrl,
      };
}

class MessageModel {
  final String id;
  final String message;
  final String createdAt;
  final String senderId;

  MessageModel({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        message: json['message'],
        createdAt: json['created_at'],
        senderId: json['sender_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'created_at': createdAt,
        'sender_id': senderId,
      };
}

class UsersChatModel {
  final String id;
  final User receiver;
  final String lastMessage;
  final String updatedAt;

  UsersChatModel({
    required this.id,
    required this.receiver,
    required this.lastMessage,
    required this.updatedAt,
  });

  factory UsersChatModel.fromJson(Map<String, dynamic> json) => UsersChatModel(
        id: json['id'],
        receiver: User.fromJson(json['receiver']),
        lastMessage: json['last_message'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'receiver': receiver.toJson(),
        'last_message': lastMessage,
        'updated_at': updatedAt,
      };
}

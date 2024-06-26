import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    String? id,
    List<String>? participants,
    List<Messages>? messages,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _participants = participants;
    _messages = messages;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Message.fromJson(dynamic json) {
    _id = json['_id'];
    _participants =
        json['participants'] != null ? json['participants'].cast<String>() : [];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  List<String>? _participants;
  List<Messages>? _messages;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  Message copyWith({
    String? id,
    List<String>? participants,
    List<Messages>? messages,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) =>
      Message(
        id: id ?? _id,
        participants: participants ?? _participants,
        messages: messages ?? _messages,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get id => _id;
  List<String>? get participants => _participants;
  List<Messages>? get messages => _messages;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['participants'] = _participants;
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));
String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
  Messages({
    String? id,
    SenderId? senderId,
    ReceiverId? receiverId,
    String? message,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _senderId = senderId;
    _receiverId = receiverId;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Messages.fromJson(dynamic json) {
    _id = json['_id'];
    _senderId =
        json['senderId'] != null ? SenderId.fromJson(json['senderId']) : null;
    _receiverId = json['receiverId'] != null
        ? ReceiverId.fromJson(json['receiverId'])
        : null;
    _message = json['message'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  SenderId? _senderId;
  ReceiverId? _receiverId;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  Messages copyWith({
    String? id,
    SenderId? senderId,
    ReceiverId? receiverId,
    String? message,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) =>
      Messages(
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        receiverId: receiverId ?? _receiverId,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get id => _id;
  SenderId? get senderId => _senderId;
  ReceiverId? get receiverId => _receiverId;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_senderId != null) {
      map['senderId'] = _senderId?.toJson();
    }
    if (_receiverId != null) {
      map['receiverId'] = _receiverId?.toJson();
    }
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

ReceiverId receiverIdFromJson(String str) =>
    ReceiverId.fromJson(json.decode(str));
String receiverIdToJson(ReceiverId data) => json.encode(data.toJson());

class ReceiverId {
  ReceiverId({
    String? id,
    String? photoLink,
  }) {
    _id = id;
    _photoLink = photoLink;
  }

  ReceiverId.fromJson(dynamic json) {
    _id = json['_id'];
    _photoLink = json['photoLink'];
  }
  String? _id;
  String? _photoLink;
  ReceiverId copyWith({
    String? id,
    String? photoLink,
  }) =>
      ReceiverId(
        id: id ?? _id,
        photoLink: photoLink ?? _photoLink,
      );
  String? get id => _id;
  String? get photoLink => _photoLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['photoLink'] = _photoLink;
    return map;
  }
}

SenderId senderIdFromJson(String str) => SenderId.fromJson(json.decode(str));
String senderIdToJson(SenderId data) => json.encode(data.toJson());

class SenderId {
  SenderId({
    String? id,
    String? photoLink,
  }) {
    _id = id;
    _photoLink = photoLink;
  }

  SenderId.fromJson(dynamic json) {
    _id = json['_id'];
    _photoLink = json['photoLink'];
  }
  String? _id;
  String? _photoLink;
  SenderId copyWith({
    String? id,
    String? photoLink,
  }) =>
      SenderId(
        id: id ?? _id,
        photoLink: photoLink ?? _photoLink,
      );
  String? get id => _id;
  String? get photoLink => _photoLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['photoLink'] = _photoLink;
    return map;
  }
}

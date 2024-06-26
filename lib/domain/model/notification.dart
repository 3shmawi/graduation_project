import 'package:donation/domain/model/messages.dart';

class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String createdAt;
  final String? postId;
  final String? commentId;
  final User? from;
  final User? to;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.createdAt,
    required this.isRead,
    this.postId,
    this.commentId,
    this.from,
    this.to,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      createdAt: json['created_at'],
      postId: json['post_id'],
      commentId: json['comment_id'],
      isRead: json['isRead'],
      to: json['to'] != null ? User.fromJson(json['to']) : null,
      from: json['from'] != null ? User.fromJson(json['from']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'created_at': createdAt,
      'post_id': postId,
      'isRead': isRead,
      'comment_id': commentId,
      'to': to?.toJson(),
      'from': from?.toJson(),
    };
  }
}

import 'package:hive/hive.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final String postId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String content;

  Post({
    required this.postId,
    required this.name,
    required this.image,
    required this.date,
    required this.content,
  });
}

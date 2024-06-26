class LikesModel {
  final String id;
  final String name;
  final String img;
  final bool isLiked;

  LikesModel(
      {required this.id,
      required this.name,
      required this.img,
      required this.isLiked});

  factory LikesModel.fromJson(Map<String, dynamic> json) {
    return LikesModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      isLiked: json['isLiked'],
    );
  }
}

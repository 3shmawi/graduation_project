import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    String? status,
    int? results,
    Data? data,
  }) {
    _status = status;
    _results = results;
    _data = data;
  }

  PostModel.fromJson(dynamic json) {
    _status = json['status'];
    _results = json['results'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _status;
  int? _results;
  Data? _data;

  PostModel copyWith({
    String? status,
    int? results,
    Data? data,
  }) =>
      PostModel(
        status: status ?? _status,
        results: results ?? _results,
        data: data ?? _data,
      );

  String? get status => _status;

  int? get results => _results;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['results'] = _results;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<Document>? document,
  }) {
    _document = document;
  }

  Data.fromJson(dynamic json) {
    if (json['document'] != null) {
      _document = [];
      json['document'].forEach((v) {
        _document?.add(Document.fromJson(v));
      });
    }
  }

  List<Document>? _document;

  Data copyWith({
    List<Document>? document,
  }) =>
      Data(
        document: document ?? _document,
      );

  List<Document>? get document => _document;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_document != null) {
      map['document'] = _document?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Document documentFromJson(String str) => Document.fromJson(json.decode(str));

String documentToJson(Document data) => json.encode(data.toJson());

class Document {
  Document({
    String? id,
    String? postID,
    UserId? userID,
    String? content,
    List<String>? photos,
    List<String>? photosLink,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _postID = postID;
    _userID = userID;
    _content = content;
    _photos = photos;
    _photosLink = photosLink;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Document.fromJson(dynamic json) {
    _id = json['_id'];
    _postID = json['postID'] ?? json['_id'];
    _userID = json['userID'] != null ? UserId.fromJson(json['userID']) : null;
    _content = json['content'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(v);
      });
    }
    if (json['photosLink'] != null) {
      _photosLink = [];
      if (json['photosLink'].isNotEmpty) {
        json['photosLink'].forEach((v) {
          _photosLink?.add(v);
        });
      }
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _postID;
  UserId? _userID;
  String? _content;
  List<String>? _photos;
  List<String>? _photosLink;
  String? _createdAt;
  String? _updatedAt;

  Document copyWith({
    String? id,
    String? postID,
    UserId? userID,
    String? content,
    List<String>? photos,
    List<String>? photosLink,
    String? createdAt,
    String? updatedAt,
  }) =>
      Document(
        id: id ?? _id,
        postID: postID ?? _postID,
        userID: userID ?? _userID,
        content: content ?? _content,
        photos: photos ?? _photos,
        photosLink: photosLink ?? _photosLink,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  String? get postID => _postID;

  UserId? get userID => _userID;

  String? get content => _content;

  List<String>? get photos => _photos;

  List<String>? get photosLink => _photosLink;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['_postID'] = _postID;
    if (_userID != null) {
      map['userID'] = _userID?.toJson();
    }
    map['content'] = _content;
    if (_photos != null) {
      map['photos'] = _photos;
    }
    if (_photosLink != null) {
      map['photosLink'] = _photosLink;
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

UserId userIdFromJson(String str) => UserId.fromJson(json.decode(str));

String userIdToJson(UserId data) => json.encode(data.toJson());

class UserId {
  UserId({
    String? id,
    String? userName,
    String? photoLink,
    String? city,
  }) {
    _id = id;
    _userName = userName;
    _photoLink = photoLink;
    _city = city;
  }

  UserId.fromJson(dynamic json) {
    _id = json['_id'];
    _userName = json['userName'];
    _photoLink = json['photoLink'];
    _city = json['city'];
  }

  String? _id;
  String? _userName;
  String? _photoLink;
  String? _city;

  UserId copyWith({
    String? id,
    String? userName,
    String? photoLink,
    String? city,
  }) =>
      UserId(
        id: id ?? _id,
        userName: userName ?? _userName,
        photoLink: photoLink ?? _photoLink,
        city: city ?? _city,
      );

  String? get id => _id;

  String? get userName => _userName;

  String? get photoLink => _photoLink;

  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userName'] = _userName;
    map['photoLink'] = _photoLink;
    map['city'] = _city;
    return map;
  }
}

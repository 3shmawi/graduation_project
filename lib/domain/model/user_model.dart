import 'dart:convert';

/// status : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MTAwODVlZWNmYzUwMDU3YzRiYjczMiIsImlhdCI6MTcxMjQxODYxMiwiZXhwIjoxNzE1MDEwNjEyfQ.33sNK4XX-LLW-Ed1tJtqZ868JInvZd-c8dyQHJ_zOcQ"
/// data : {"user":{"location":{"coordinates":[]},"_id":"6610085eecfc50057c4bb732","email":"mohamedashmawy918@gmail.com","verified":true,"photoLink":"","createdAt":"2024-04-05T14:19:10.940Z","updatedAt":"2024-04-05T14:19:40.691Z","__v":0}}

UserModel userModeFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    String? status,
    String? token,
    Data? data,
  }) {
    _status = status;
    _token = token;
    _data = data;
  }

  UserModel.fromJson(dynamic json) {
    _status = json['status'];
    _token = json['token'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _token;
  Data? _data;
  UserModel copyWith({
    String? status,
    String? token,
    Data? data,
  }) =>
      UserModel(
        status: status ?? _status,
        token: token ?? _token,
        data: data ?? _data,
      );
  String? get status => _status;
  String? get token => _token;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['token'] = _token;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// user : {"location":{"coordinates":[]},"_id":"6610085eecfc50057c4bb732","email":"mohamedashmawy918@gmail.com","verified":true,"photoLink":"","createdAt":"2024-04-05T14:19:10.940Z","updatedAt":"2024-04-05T14:19:40.691Z","__v":0}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    User? user,
  }) {
    _user = user;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;
  Data copyWith({
    User? user,
  }) =>
      Data(
        user: user ?? _user,
      );
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// location : {"coordinates":[]}
/// _id : "6610085eecfc50057c4bb732"
/// email : "mohamedashmawy918@gmail.com"
/// verified : true
/// photoLink : ""
/// createdAt : "2024-04-05T14:19:10.940Z"
/// updatedAt : "2024-04-05T14:19:40.691Z"
/// __v : 0

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    Location? location,
    String? id,
    String? email,
    bool? verified,
    String? photoLink,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _location = location;
    _id = id;
    _email = email;
    _verified = verified;
    _photoLink = photoLink;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  User.fromJson(dynamic json) {
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _id = json['_id'];
    _email = json['email'];
    _verified = json['verified'];
    _photoLink = json['photoLink'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  Location? _location;
  String? _id;
  String? _email;
  bool? _verified;
  String? _photoLink;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  User copyWith({
    Location? location,
    String? id,
    String? email,
    bool? verified,
    String? photoLink,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      User(
        location: location ?? _location,
        id: id ?? _id,
        email: email ?? _email,
        verified: verified ?? _verified,
        photoLink: photoLink ?? _photoLink,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  Location? get location => _location;
  String? get id => _id;
  String? get email => _email;
  bool? get verified => _verified;
  String? get photoLink => _photoLink;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['_id'] = _id;
    map['email'] = _email;
    map['verified'] = _verified;
    map['photoLink'] = _photoLink;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

/// coordinates : []

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    List<dynamic>? coordinates,
  }) {
    _coordinates = coordinates;
  }

  Location.fromJson(dynamic json) {
    if (json['coordinates'] != null) {
      _coordinates = [];
      json['coordinates'].forEach((v) {
        _coordinates?.add(v);
      });
    }
  }
  List<dynamic>? _coordinates;
  Location copyWith({
    List<dynamic>? coordinates,
  }) =>
      Location(
        coordinates: coordinates ?? _coordinates,
      );
  List<dynamic>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    Model? model,
  }) {
    _model = model;
  }

  Data.fromJson(dynamic json) {
    _model = json['model'] != null ? Model.fromJson(json['model']) : null;
  }

  Model? _model;

  Data copyWith({
    Model? model,
  }) =>
      Data(
        model: model ?? _model,
      );

  Model? get model => _model;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_model != null) {
      map['model'] = _model?.toJson();
    }
    return map;
  }
}

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    Location? location,
    String? id,
    String? userName,
    String? city,
    String? email,
    String? role,
    String? userType,
    bool? verified,
    String? photoLink,
    String? createdAt,
    String? updatedAt,
    int? v,
    String? passwordResetExpires,
    String? passwordHash,
  }) {
    _location = location;
    _id = id;
    _userName = userName;
    _city = city;
    _email = email;
    _role = role;
    _userType = userType;
    _verified = verified;
    _photoLink = photoLink;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _passwordResetExpires = passwordResetExpires;
    _passwordHash = passwordHash;
  }

  Model.fromJson(dynamic json) {
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _id = json['_id'];
    _userName = json['userName'];
    _city = json['city'];
    _email = json['email'];
    _role = json['role'];
    _userType = json['userType'];
    _verified = json['verified'];
    _photoLink = json['photoLink'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _passwordResetExpires = json['passwordResetExpires'];
    _passwordHash = json['passwordHash'];
  }

  Location? _location;
  String? _id;
  String? _userName;
  String? _city;
  String? _email;
  String? _role;
  String? _userType;
  bool? _verified;
  String? _photoLink;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  String? _passwordResetExpires;
  String? _passwordHash;

  Model copyWith({
    Location? location,
    String? id,
    String? userName,
    String? city,
    String? email,
    String? role,
    String? userType,
    bool? verified,
    String? photoLink,
    String? createdAt,
    String? updatedAt,
    int? v,
    String? passwordResetExpires,
    String? passwordHash,
  }) =>
      Model(
        location: location ?? _location,
        id: id ?? _id,
        userName: userName ?? _userName,
        city: city ?? _city,
        email: email ?? _email,
        role: role ?? _role,
        userType: userType ?? _userType,
        verified: verified ?? _verified,
        photoLink: photoLink ?? _photoLink,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
        passwordResetExpires: passwordResetExpires ?? _passwordResetExpires,
        passwordHash: passwordHash ?? _passwordHash,
      );

  Location? get location => _location;

  String? get id => _id;

  String? get userName => _userName;
  String? get city => _city;

  String? get email => _email;

  String? get role => _role;

  String? get userType => _userType;

  bool? get verified => _verified;

  String? get photoLink => _photoLink;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get v => _v;

  String? get passwordResetExpires => _passwordResetExpires;

  String? get passwordHash => _passwordHash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['_id'] = _id;
    map['userName'] = _userName;
    map['city'] = _city;
    map['email'] = _email;
    map['role'] = _role;
    map['userType'] = _userType;
    map['verified'] = _verified;
    map['photoLink'] = _photoLink;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['passwordResetExpires'] = _passwordResetExpires;
    map['passwordHash'] = _passwordHash;
    return map;
  }
}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    List<String>? coordinates,
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

  List<String>? _coordinates;

  Location copyWith({
    List<String>? coordinates,
  }) =>
      Location(
        coordinates: coordinates ?? _coordinates,
      );

  List<dynamic>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_coordinates != null) {
      map['coordinates'] = _coordinates;
    }
    return map;
  }
}

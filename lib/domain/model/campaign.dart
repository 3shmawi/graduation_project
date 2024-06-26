import 'dart:convert';

CampaignModel documentModelFromJson(String str) =>
    CampaignModel.fromJson(json.decode(str));

String documentModelToJson(CampaignModel data) => json.encode(data.toJson());

class CampaignModel {
  CampaignModel({
    String? status,
    int? results,
    Data? data,
  }) {
    _status = status;
    _results = results;
    _data = data;
  }

  CampaignModel.fromJson(dynamic json) {
    _status = json['status'];
    _results = json['results'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _status;
  int? _results;
  Data? _data;

  CampaignModel copyWith({
    String? status,
    int? results,
    Data? data,
  }) =>
      CampaignModel(
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
    List<Campaign>? document,
  }) {
    _document = document;
  }

  Data.fromJson(dynamic json) {
    if (json['document'] != null) {
      _document = [];
      json['document'].forEach((v) {
        _document?.add(Campaign.fromJson(v));
      });
    }
  }

  List<Campaign>? _document;

  Data copyWith({
    List<Campaign>? document,
  }) =>
      Data(
        document: document ?? _document,
      );

  List<Campaign>? get document => _document;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_document != null) {
      map['document'] = _document?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Campaign documentFromJson(String str) => Campaign.fromJson(json.decode(str));

String documentToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  Campaign({
    String? id,
    UserId? userID,
    String? title,
    String? titleDescription,
    String? aboutCampaign,
    int? beneficiaries,
    String? category,
    List<String>? photos,
    List<String>? photosLink,
    int? remainingAmount,
    int? totalAmount,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userID = userID;
    _title = title;
    _titleDescription = titleDescription;
    _aboutCampaign = aboutCampaign;
    _beneficiaries = beneficiaries;
    _category = category;
    _photos = photos;
    _photosLink = photosLink;
    _remainingAmount = remainingAmount;
    _totalAmount = totalAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Campaign.fromJson(dynamic json) {
    _id = json['_id'];
    _userID = json['userID'] != null ? UserId.fromJson(json['userID']) : null;
    _title = json['title'];
    _titleDescription = json['titleDescription'];
    _aboutCampaign = json['aboutCampaign'];
    _beneficiaries = json['beneficiaries'];
    _category = json['category'];
    if (json['photos'] != null) {
      _photos = [];
      json['photos'].forEach((v) {
        _photos?.add(v);
      });
    }
    if (json['photosLink'] != null) {
      _photosLink = [];
      json['photosLink'].forEach((v) {
        _photosLink?.add(v);
      });
    }
    _remainingAmount = json['remainingAmount'];
    _totalAmount = json['totalAmount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  UserId? _userID;
  String? _title;
  String? _titleDescription;
  String? _aboutCampaign;
  int? _beneficiaries;
  String? _category;
  List<String>? _photos;
  List<String>? _photosLink;
  int? _remainingAmount;
  int? _totalAmount;
  String? _createdAt;
  String? _updatedAt;

  Campaign copyWith({
    String? id,
    UserId? userID,
    String? title,
    String? titleDescription,
    String? aboutCampaign,
    int? beneficiaries,
    String? category,
    List<String>? photos,
    List<String>? photosLink,
    int? remainingAmount,
    int? totalAmount,
    String? createdAt,
    String? updatedAt,
  }) =>
      Campaign(
        id: id ?? _id,
        userID: userID ?? _userID,
        title: title ?? _title,
        titleDescription: titleDescription ?? _titleDescription,
        aboutCampaign: aboutCampaign ?? _aboutCampaign,
        beneficiaries: beneficiaries ?? _beneficiaries,
        category: category ?? _category,
        photos: photos ?? _photos,
        photosLink: photosLink ?? _photosLink,
        remainingAmount: remainingAmount ?? _remainingAmount,
        totalAmount: totalAmount ?? _totalAmount,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  String? get id => _id;

  UserId? get userID => _userID;

  String? get title => _title;

  String? get titleDescription => _titleDescription;

  String? get aboutCampaign => _aboutCampaign;

  int? get beneficiaries => _beneficiaries;

  String? get category => _category;

  List<String>? get photos => _photos;

  List<String>? get photosLink => _photosLink;

  int? get remainingAmount => _remainingAmount;

  int? get totalAmount => _totalAmount;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_userID != null) {
      map['userID'] = _userID?.toJson();
    }
    map['title'] = _title;
    map['titleDescription'] = _titleDescription;
    map['aboutCampaign'] = _aboutCampaign;
    map['beneficiaries'] = _beneficiaries;
    map['category'] = _category;
    if (_photos != null) {
      map['photos'] = _photos;
    }
    if (_photosLink != null) {
      map['photosLink'] = _photosLink;
    }
    map['remainingAmount'] = _remainingAmount;
    map['totalAmount'] = _totalAmount;
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
  }) {
    _id = id;
    _userName = userName;
    _photoLink = photoLink;
  }

  UserId.fromJson(dynamic json) {
    _id = json['_id'];
    _userName = json['userName'];
    _photoLink = json['photoLink'];
  }

  String? _id;
  String? _userName;
  String? _photoLink;

  UserId copyWith({
    String? id,
    String? userName,
    String? photoLink,
  }) =>
      UserId(
        id: id ?? _id,
        userName: userName ?? _userName,
        photoLink: photoLink ?? _photoLink,
      );

  String? get id => _id;

  String? get userName => _userName;

  String? get photoLink => _photoLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userName'] = _userName;
    map['photoLink'] = _photoLink;
    return map;
  }
}

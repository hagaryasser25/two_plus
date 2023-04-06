import 'package:flutter/cupertino.dart';

class Complains {
  Complains({
    String? id,
    String? name,
    String? phoneNumber,
    String? description,
    String? userUid,
    int? date,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _description = description;
    _userUid = userUid;
    _date = date;
  }

  Complains.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _description = json['description'];
    _userUid = json['userUid'];
    _date = json['date'];
  }

  String? _id;
  String? _name;
  String? _phoneNumber;
  String? _description;
  String? _userUid;
  int? _date;

  String? get id => _id;
  String? get name => _name;
   String? get phoneNumber =>_phoneNumber;
  String? get description => _description;
  String? get userUid => _userUid;
  int? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['description'] = _description;
    map['user_userUid'] = _userUid;
    map['date'] = _date;

    return map;
  }
}
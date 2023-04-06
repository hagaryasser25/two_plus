import 'package:flutter/cupertino.dart';

class Subscription {
  Subscription({
    String? id,
    int? currentNumber,
    String? name,
    String? month,
    int? offer,
    String? uid,
    String? phoneNumber,
    String? status,
  }) {
    _id = id;
    _currentNumber = currentNumber;
    _name = name;
    _month = month;
    _offer = offer;
    _uid = uid;
    _phoneNumber = phoneNumber;
    _status = status;
  }

  Subscription.fromJson(dynamic json) {
    _id = json['id'];
    _currentNumber = json['currentNumber'];
    _name = json['name'];
    _month = json['month'];
    _offer = json['offer'];
    _uid = json['uid'];
    _phoneNumber = json['phoneNumber'];
    _status = json['status'];
  }

  String? _id;
  int? _currentNumber;
  String? _name;
  String? _month;
  int? _offer;
  String? _uid;
  String? _phoneNumber;
  String? _status;

  String? get id => _id;
  int? get currentNumber => _currentNumber;
  String? get name => _name;
  String? get month => _month;
  int? get offer => _offer;
  String? get uid => _uid;
  String? get phoneNumber => _phoneNumber;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['currentNumber'] = _currentNumber;
    map['name'] = _name;
    map['month'] = _month;
    map['offer'] = _offer;
    map['uid'] = _uid;
    map['phoneNumber'] = _phoneNumber;
    map['status'] = _status;

    return map;
  }
}

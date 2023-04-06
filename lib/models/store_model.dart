import 'package:flutter/cupertino.dart';

class Store {
  Store({
    String? id,
    String? email,
    String? name,
    String? password,
    String? phoneNumber,
    String? uid,
    String? imageUrl,
    String? isSubscribe,
  }) {
    _id = id;
    _email = email;
    _name = name;
    _password = password;
    _phoneNumber = phoneNumber;
    _uid = uid;
    _imageUrl = imageUrl;
    _isSubscribe = isSubscribe;
  }

  Store.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phoneNumber = json['phoneNumber'];
    _uid = json['uid'];
    _imageUrl = json['imageUrl'];
    _isSubscribe = json['isSubscribe'];
  }

  String? _id;
  String? _email;
  String? _name;
  String? _password;
  String? _phoneNumber;
  String? _uid;
  String? _imageUrl;
  String? _isSubscribe;

  String? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phoneNumber => _phoneNumber;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;
  String? get isSubscribe => _isSubscribe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phoneNumber'] = _phoneNumber;
    map['uid'] = _uid;
    map['imageUrl'] = _imageUrl;
    map['isSubscribe'] = _isSubscribe;

    return map;
  }
}

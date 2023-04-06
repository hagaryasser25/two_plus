import 'package:flutter/cupertino.dart';

class Price {
  Price({
    String? id,
    String? price,
    int? date,

  }) {
    _id = id;
    _price = price;
    _date = date;

  }

  Price.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _date = json['date'];
  }

  String? _id;
  String? _price;
  int? _date;


  String? get id => _id;
  String? get price => _price;
  int? get date => _date;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['date'] = _date;


    return map;
  }
}
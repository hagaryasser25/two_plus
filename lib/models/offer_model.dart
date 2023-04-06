import 'package:flutter/cupertino.dart';

class Offer {
  Offer({
    String? id,
    String? price,
    int? name,
    String? description,

  }) {
    _id = id;
    _price = price;
    _name = name;
    _description = description;

  }

  Offer.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _name = json['name'];
    _description = json['description'];
  }

  String? _id;
  String? _price;
  int? _name;
  String? _description;


  String? get id => _id;
  String? get price => _price;
  int? get name => _name;
  String? get description => _description;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['name'] = _name;
    map['description'] = _description;


    return map;
  }
}

import 'package:flutter/cupertino.dart';

class Phones {
  Phones({
    String? id,
    String? name,
    String? imageUrl,
    String? space,
    String? ram,
    String? color,
    String? details,
    String? price1,
    String? price2,
    String? price3,
    String? store,
    int? rating,
  }) {
    _id = id;
    _name = name;
    _imageUrl = imageUrl;
    _space = space;
    _ram = ram;
    _color = color;
    _details = details;
    _price1 = price1;
    _price2 = price2;
    _price3 = price3;
    _store = store;
    _rating = rating;
  }

  Phones.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    _space = json['space'];
    _ram = json['ram'];
    _color = json['color'];
    _details = json['details'];
    _price1 = json['price1'];
    _price2 = json['price2'];
    _price3 = json['price3'];
    _store = json['store'];
    _rating = json['rating'];
  }

  String? _id;
  String? _name;
  String? _imageUrl;
  String? _space;
  String? _ram;
  String? _color;
  String? _details;
  String? _price1;
  String? _price2;
  String? _price3;
  String? _store;
  int? _rating;

  String? get id => _id;
  String? get name => _name;
  String? get imageUrl => _imageUrl;
  String? get space => _space;
  String? get ram => _ram;
  String? get color => _color;
  String? get details => _details;
  String? get price1 => _price1;
  String? get price2 => _price2;
  String? get price3 => _price3;
  String? get store => _store;
  int? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageUrl'] = _imageUrl;
    map['space'] = _space;
    map['ram'] = _ram;
    map['color'] = _color;
    map['details'] = _details;
    map['price1'] = _price1;
    map['price2'] = _price2;
    map['price3'] = _price3;
    map['store'] = _store;
    map['rating'] = _rating;

    return map;
  }
}
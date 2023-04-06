import 'package:flutter/cupertino.dart';

class Products {
  Products({
    String? id,
    String? name,
    String? imageUrl,
    String? space,
    String? ram,
    String? color,
    String? details,
    int? rating,
  }) {
    _id = id;
    _name = name;
    _imageUrl = imageUrl;
    _space = space;
    _ram = ram;
    _color = color;
    _details = details;
    _rating = rating;
  }

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    _space = json['space'];
    _ram = json['ram'];
    _color = json['color'];
    _details = json['details'];
    _rating = json['rating'];
  }

  String? _id;
  String? _name;
  String? _imageUrl;
  String? _space;
  String? _ram;
  String? _color;
  String? _details;
  int? _rating;

  String? get id => _id;
  String? get name => _name;
  String? get imageUrl => _imageUrl;
  String? get space => _space;
  String? get ram => _ram;
  String? get color => _color;
  String? get details => _details;
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
    map['rating'] = _rating;

    return map;
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class CartModel {
  String id;
  String imagePath;
  String title;
  String colorIconPath;
  String color;
  int count;
  double rating;
  double price;

  CartModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.colorIconPath,
    required this.color,
    required this.count,
    required this.rating,
    required this.price,
  });

  CartModel copyWith({
    String? id,
    String? imagePath,
    String? title,
    String? colorIconPath,
    String? color,
    int? count,
    double? rating,
    double? price,
  }) {
    return CartModel(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      colorIconPath: colorIconPath ?? this.colorIconPath,
      color: color ?? this.color,
      count: count ?? this.count,
      rating: rating ?? this.rating,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'imagePath': imagePath,
      'title': title,
      'colorIconPath': colorIconPath,
      'color': color,
      'count': count,
      'rating': rating,
      'price' : price,
    };
  }

  static double _parsePrice(dynamic priceValue) {
    debugPrint("the dynamice price is ${priceValue}");
    if (priceValue == null) return 0.0;
    try {
      String cleaned = priceValue.toString().replaceAll('\$', '').replaceAll(',', '');
      return double.tryParse(cleaned) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id']?? "",
      imagePath: map['imagePath']?? "",
      title: map['title'],
      colorIconPath: map['colorIconPath'],
      color: map['color'],
      count: map['count'],
      rating: map['rating'].toDouble(),
      price: _parsePrice(map['price']),
    );
  }


  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));
}


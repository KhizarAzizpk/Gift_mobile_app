// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  String imagePath;
  String name;
  String rating;
  String soldcount;
  ProductModel({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.soldcount,
  });

  ProductModel copyWith({
    String? imagePath,
    String? name,
    String? rating,
    String? soldcount,
  }) {
    return ProductModel(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      soldcount: soldcount ?? this.soldcount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'name': name,
      'rating': rating,
      'soldcount': soldcount,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      imagePath: map['imagePath'] as String,
      name: map['name'] as String,
      rating: map['rating'] as String,
      soldcount: map['soldcount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(imagePath: $imagePath, name: $name, rating: $rating, soldcount: $soldcount)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath &&
        other.name == name &&
        other.rating == rating &&
        other.soldcount == soldcount;
  }

  @override
  int get hashCode {
    return imagePath.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        soldcount.hashCode;
  }
}

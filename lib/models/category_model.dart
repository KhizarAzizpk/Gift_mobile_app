// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  String iconPath;
  String name;
  CategoryModel({
    required this.iconPath,
    required this.name,
  });

  CategoryModel copyWith({
    String? iconPath,
    String? name,
  }) {
    return CategoryModel(
      iconPath: iconPath ?? this.iconPath,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iconPath': iconPath,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      iconPath: map['iconPath'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(iconPath: $iconPath, name: $name)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.iconPath == iconPath && other.name == name;
  }

  @override
  int get hashCode => iconPath.hashCode ^ name.hashCode;
}

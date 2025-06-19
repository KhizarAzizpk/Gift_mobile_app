// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'dart:convert';

AllProductsModel allProductsModelFromJson(String str) =>
    AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) =>
    json.encode(data.toJson());

class AllProductsModel {
  int status;
  String message;
  List<Products> data;

  AllProductsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        status: json["status"],
        message: json["message"],
        data:
            List<Products>.from(json["data"].map((x) => Products.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Products {
  int id;
  String name;
  MainCategory mainCategory;
  SubCategory subCategory;
  String image;
  String link;
  double ratings;
  int noOfRatings;
  int discountPrice;
  int actualPrice;

  Products({
    required this.id,
    required this.name,
    required this.mainCategory,
    required this.subCategory,
    required this.image,
    required this.link,
    required this.ratings,
    required this.noOfRatings,
    required this.discountPrice,
    required this.actualPrice,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        name: json["name"],
        mainCategory: mainCategoryValues.map[json["mainCategory"]]!,
        subCategory: subCategoryValues.map[json["subCategory"]]!,
        image: json["image"],
        link: json["link"],
        ratings: json["ratings"]?.toDouble(),
        noOfRatings: json["noOfRatings"],
        discountPrice: json["discountPrice"],
        actualPrice: json["actualPrice"],
      );

  get soldcount => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mainCategory": mainCategoryValues.reverse[mainCategory],
        "subCategory": subCategoryValues.reverse[subCategory],
        "image": image,
        "link": link,
        "ratings": ratings,
        "noOfRatings": noOfRatings,
        "discountPrice": discountPrice,
        "actualPrice": actualPrice,
      };
}

enum MainCategory { TV_AUDIO_CAMERAS }

final mainCategoryValues =
    EnumValues({"tv, audio & cameras": MainCategory.TV_AUDIO_CAMERAS});

enum SubCategory { ALL_ELECTRONICS }

final subCategoryValues =
    EnumValues({"All Electronics": SubCategory.ALL_ELECTRONICS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

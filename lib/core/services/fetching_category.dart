import 'dart:convert';

import 'package:gift_mobile_app/models/all_products_model.dart';
import 'package:http/http.dart' as http;

import '../../models/newproduct_model.dart';



class AmazonService {
  static const String _baseUrl = 'https://real-time-amazon-data.p.rapidapi.com/search';
  static const Map<String, String> _headers = {
    'x-rapidapi-host': 'real-time-amazon-data.p.rapidapi.com',
    'x-rapidapi-key': '2f435e7819mshb7a88087d8b12ddp114616jsn1a28af6ad5e7',
  };

  // static Future<List<Product>> fetchProducts({required int page}) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl?query=Gifts%20for%20Kids&page=$page&page_size=100&country=US&sort_by=RELEVANCE&product_condition=ALL&is_prime=false&deals_and_discounts=NONE'),
  //     headers: _headers,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     print(response.body);
  //     final List productsJson = jsonData['data']['products'];
  //
  //     return productsJson.map((json) => Product.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load page $page');
  //   }
  // }
  static Future<List<Product>> fetchProducts({
    required int page,
    String? interested,
    String? notInterested,
    String? theme,
    String? occasion,
  }) async {
    // Build dynamic query using provided filters
    List<String> queryParts = [];

    if (interested != null && interested.isNotEmpty) queryParts.add(interested);
    if (theme != null && theme.isNotEmpty) queryParts.add(theme);
    if (occasion != null && occasion.isNotEmpty) queryParts.add(occasion);
    // Don't add notInterested here — we’ll filter that locally

    final query = queryParts.join(' '); // e.g., "Toys Birthday Superhero"

    final response = await http.get(
      Uri.parse('$_baseUrl?query=$query&page=$page&page_size=100&country=US&sort_by=RELEVANCE&product_condition=ALL&is_prime=false&deals_and_discounts=NONE'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("to find out the error");
      print(response.body);
      final List productsJson = jsonData['data']['products'];

      // Local filtering for notInterested
      List<Product> allProducts = productsJson.map((json) => Product.fromJson(json)).toList();

      if (notInterested != null && notInterested.isNotEmpty) {
        allProducts = allProducts.where((product) {
          return !product.title.toLowerCase().contains(notInterested.toLowerCase());
        }).toList();
      }

      return allProducts;
    } else {
      throw Exception('Failed to load page $page');
    }
  }

}


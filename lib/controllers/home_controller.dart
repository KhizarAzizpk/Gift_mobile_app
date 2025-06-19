import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/all_products_model.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  List<Products> allProducts = [];
  List<Products> filteredProducts = []; // To store filtered data

  @override
  void onInit() {
    super.onInit();
    // fetchAllProducts();
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  // Fetch All Products API


  // Future<void> fetchAllProducts() async {
  //   debugPrint('Request URL: $baseUrl/api/user/fetchAllProducts');
  //   var request =
  //       http.Request('GET', Uri.parse('$baseUrl/api/user/fetchAllProducts'));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     // Decode the response data
  //     var data = jsonDecode(await response.stream.bytesToString());
  //
  //     // Create AllProductsModel from the decoded data
  //     var products = AllProductsModel.fromJson(data);
  //     allProducts = products.data;
  //     debugPrint('Fetched Products: ${allProducts.toString()}');
  //     filteredProducts = List.from(allProducts); // Initialize with all products
  //   } else {
  //     debugPrint('Error: ${response.reasonPhrase}');
  //   }
  // }

  // Filter products based on multiple criteria
  void filterProducts({
    String? name,
    MainCategory? mainCategory,
    SubCategory? subCategory,
    double? minRatings,
    double? maxRatings,
    int? minDiscountPrice,
    int? maxDiscountPrice,
    int? minActualPrice,
    int? maxActualPrice,
  }) {
    filteredProducts = allProducts.where((product) {
      bool matches = true;

      // Check if name matches
      if (name != null &&
          !product.name.toLowerCase().contains(name.toLowerCase())) {
        matches = false;
      }

      // Check if mainCategory matches
      if (mainCategory != null && product.mainCategory != mainCategory) {
        matches = false;
      }

      // Check if subCategory matches
      if (subCategory != null && product.subCategory != subCategory) {
        matches = false;
      }

      // Check if ratings are within range
      if (minRatings != null && product.ratings < minRatings) {
        matches = false;
      }
      if (maxRatings != null && product.ratings > maxRatings) {
        matches = false;
      }

      // Check if discount price is within range
      if (minDiscountPrice != null &&
          product.discountPrice < minDiscountPrice) {
        matches = false;
      }
      if (maxDiscountPrice != null &&
          product.discountPrice > maxDiscountPrice) {
        matches = false;
      }

      // Check if actual price is within range
      if (minActualPrice != null && product.actualPrice < minActualPrice) {
        matches = false;
      }
      if (maxActualPrice != null && product.actualPrice > maxActualPrice) {
        matches = false;
      }

      return matches;
    }).toList();

    debugPrint('Filtered Products: ${filteredProducts.toString()}');
  }
}

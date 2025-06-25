import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/favorite_controller.dart';
import 'package:gift_mobile_app/models/favorite_model.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';

import 'package:gift_mobile_app/utils/constants/app_string.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Favorite"),
        titleTextStyle: AppStyle.urbanistBold24Black,

      ),
      body: Obx(() {
        if (favoriteController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (favoriteController.favoriteProducts.isEmpty) {
          return Center(child: Text("No favorite products yet"));
        }

        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: favoriteController.favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteController.favoriteProducts[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          product.image,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            favoriteController.removeFromFavorites(product.id);
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

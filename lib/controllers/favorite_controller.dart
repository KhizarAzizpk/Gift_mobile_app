import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/favorite_model.dart';

class FavoriteController extends GetxController {
  final RxList<FavoriteModel> favoriteProducts = <FavoriteModel>[].obs;
  final RxBool isLoading = true.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchFavoritesFromFirestore(); // Load favorites on startup
  }

  /// Add product to favorites
  Future<void> addToFavorites(FavoriteModel product) async {
    if (user == null) return;

    try {
      // Prevent duplicates
      if (favoriteProducts.any((item) => item.id == product.id)) return;

      favoriteProducts.add(product);

      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .doc(product.id)
          .set(product.toMap());
    } catch (e) {
      print("❌ Error adding to favorites: $e");
    }
  }

  /// Remove product from favorites
  Future<void> removeFromFavorites(String productId) async {
    if (user == null) return;

    try {
      favoriteProducts.removeWhere((item) => item.id == productId);

      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .doc(productId)
          .delete();
    } catch (e) {
      print("❌ Error removing from favorites: $e");
    }
  }

  /// Fetch favorites from Firestore
  Future<void> fetchFavoritesFromFirestore() async {
    if (user == null) return;

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('favorites')
          .get();

      favoriteProducts.value = snapshot.docs
          .map((doc) => FavoriteModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print("❌ Error fetching favorites: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if a product is in favorites
  bool isFavorited(String productId) {
    return favoriteProducts.any((item) => item.id == productId);
  }

  /// Toggle favorite state
  Future<void> toggleFavorite(FavoriteModel product) async {
    if (isFavorited(product.id)) {
      await removeFromFavorites(product.id);
    } else {
      await addToFavorites(product);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/cart_model.dart';

import '../models/order_model.dart';

class CartController extends GetxController {
  final cartItems = <CartModel>[].obs;
  final isloading = true.obs;// var to see if the data is still loading
  final selectedItems = <CartModel>[].obs;
  void selecteditem(List<CartModel>item){
    selectedItems.value = item;
  }
  //** logic for cart checkout...

  final selectedCartItemIds = <String>{}.obs;

  void toggleSelectedItem(String productId) {
    if (selectedCartItemIds.contains(productId)) {
      selectedCartItemIds.clear(); // deselect if already selected
    } else {
      selectedCartItemIds.clear(); // allow only one selection
      selectedCartItemIds.add(productId);
    }
  }


  void prepareSelectedItems() {
    selectedItems.value = cartItems
        .where((item) => selectedCartItemIds.contains(item.id))
        .toList();
  }
  ////////***
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchCartFromFirestore(); // load existing cart on init
  }

  void addToCart(CartModel cartItem) {
    // Check if item already exists by title and color (you can change the logic if needed)
    final index = cartItems.indexWhere(
        (item) => item.title == cartItem.title && item.color == cartItem.color);

    if (index != -1) {
      // If already exists, update quantity
      final updatedItem = cartItems[index].copyWith(
        count: cartItems[index].count + cartItem.count,
      );
      cartItems[index] = updatedItem;
    } else {
      cartItems.add(cartItem);
    }

    updateCartInFirestore();
  }

  void removeCartProduct(CartModel cartItem) {
    cartItems.removeWhere((item) => item.id == cartItem.id);
    updateCartInFirestore();
  }

  void incrementItem(int index) {
    final updatedItem = cartItems[index].copyWith(
      count: cartItems[index].count + 1,
    );
    cartItems[index] = updatedItem;
    updateCartInFirestore();
  }

  void decrementItem(int index) {
    if (cartItems[index].count > 1) {
      final updatedItem = cartItems[index].copyWith(
        count: cartItems[index].count - 1,
      );
      cartItems[index] = updatedItem;
      updateCartInFirestore();
    } else {
      removeCartProduct(cartItems[index]);
    }
  }

  void clearCart() {
    cartItems.clear();
    updateCartInFirestore();
  }

  Future<void> updateCartInFirestore() async {
    if (user == null) return;

    final cartData = cartItems.map((e) => e.toMap()).toList();

    await _firestore.collection('users').doc(user!.uid).set({
      'cart': cartData,
    }, SetOptions(merge: true));
  }

  Future<void> fetchCartFromFirestore() async {
    if (user == null) {
      return;
    }

    // if there is no user there will be no cart ...
    try {
      final doc = await _firestore.collection('users').doc(user!.uid).get();

      if (doc.exists && doc.data()?['cart'] != null) {
        List<dynamic> cartList = doc.data()!['cart'];
        cartItems.value = cartList.map((e) => CartModel.fromMap(e)).toList();
      } else {
        cartItems.clear();
      }
    } catch (e) {
      print("Error fetching cart: $e");
    } finally {
      isloading.value = false; // Done loading
    }
  }
  /////
  Future<void> placeOrder(OrderModel order) async {
    if (user == null) return;

    try {
      // Store in user's orders collection
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .collection('orders')
          .add(order.toJson());

      // Remove item from cart
      cartItems.removeWhere((item) => item.id == order.productId);
      updateCartInFirestore();

      Get.snackbar(
        "Order Placed",
        "Your order has been successfully placed.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Order Failed",
        "Something went wrong while placing order.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Order error: $e");
    }
  }


}

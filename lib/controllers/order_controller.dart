import 'dart:ffi';

import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/OrderTrackerController.dart';
import 'package:gift_mobile_app/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/newproduct_model.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  var ongoingOrders = <OrderModel>[].obs;
  var completedOrders = <OrderModel>[].obs;
  var isloading = true.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save order to Firestore
  Future<void> addOrderToFirestore(Product product) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) {
      isloading.value = false;
      return;
    }

    final newOrderRef =
        _firestore.collection('users').doc(userId).collection('orders').doc();

    final order = OrderModel(
      orderId: newOrderRef.id,
      productId: product.id,
      title: product.title,
      image: product.image,
      price: product.price,
      ratings: product.ratings,
      description: product.description,
      isCompleted: false,
      timestamp: DateTime.now(),
      currentStep: 0, //it is releated to the progress not order ..

      //quantity: product.quantity,
    );

    await newOrderRef.set(order.toJson());
    ongoingOrders.add(order); // also update local list
  }

  // Fetch user's orders from Firestore
  Future<void> fetchOrdersFromFirestore() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .get();
    final orders = snapshot.docs.map((doc) {
      return OrderModel.fromJson(doc.data());
    }).toList();
    isloading.value = false;

    ongoingOrders.assignAll(orders.where((o) => !o.isCompleted).toList());
    ongoingOrders.value = orders.where((orders)=>orders.currentStep <4).toList();
    completedOrders.assignAll(orders.where((o) => o.isCompleted).toList());
    //tracker
    final tracker = Get.find<OrderTrackerController>();
    for(var order in ongoingOrders){
      tracker.startTracking(order);
    }
  }

  // Mark order as completed (locally and in Firestore)
  Future<void> completeOrder(int index) async {
    final order = ongoingOrders[index];
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.orderId);

    await docRef.update({'isCompleted': true});
    ongoingOrders.removeAt(index);
    completedOrders.add(order.copyWith(isCompleted: true));
  }

  void clearOngoingOrders() {
    ongoingOrders.clear();
  }

  void clearCompletedorder() {
    completedOrders.clear();
  }

  //upadate step function

  Future<void> updateOrderStep(String orderId, int newStep) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId);
    await docRef.update({
      'currentStep': newStep,
    });
    //updating locally
    int index = ongoingOrders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      final updatedOrder = ongoingOrders[index].copyWith(currentStep: newStep);
      ongoingOrders[index] = updatedOrder;
    }
  }
  //pl
}

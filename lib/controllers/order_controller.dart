import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gift_mobile_app/controllers/OrderTrackerController.dart';
import 'package:gift_mobile_app/models/order_model.dart';
import 'package:gift_mobile_app/models/newproduct_model.dart';

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

    final orderRef = _firestore.collection('users').doc(userId).collection('orders');

    final existingOrderSnapshot = await orderRef
        .where('productId', isEqualTo: product.id)
        .where('isCompleted', isEqualTo: false)
        .limit(1)
        .get();

    if (existingOrderSnapshot.docs.isNotEmpty) {
      final doc = existingOrderSnapshot.docs.first;
      final currentQuantity = doc['quantity'] ?? 1;

      await doc.reference.update({
        'quantity': currentQuantity + product.quantity,
        'timestamp': DateTime.now(),
      });

      final index = ongoingOrders.indexWhere((o) => o.orderId == doc.id);
      if (index != -1) {
        final updatedOrder = ongoingOrders[index].copyWith(
          quantity: currentQuantity + product.quantity,
          timestamp: DateTime.now(),
        );
        ongoingOrders[index] = updatedOrder;
      }
      return;
    }

    final newOrderRef = orderRef.doc();

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
      currentStep: 0,
      quantity: product.quantity,
    );

    await newOrderRef.set(order.toJson());
    ongoingOrders.add(order);
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

    ongoingOrders.assignAll(
      orders.where((o) => !o.isCompleted && o.currentStep < 4).toList(),
    );

    completedOrders.assignAll(
      orders.where((o) => o.isCompleted).toList(),
    );

    final tracker = Get.find<OrderTrackerController>();
    for (var order in ongoingOrders) {
      tracker.startTracking(order);
    }
  }

  // Mark order as completed
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

  // Update step
  Future<void> updateOrderStep(String orderId, int newStep) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId);

    await docRef.update({'currentStep': newStep});

    final index = ongoingOrders.indexWhere((o) => o.orderId == orderId);
    if (index != -1) {
      final updatedOrder = ongoingOrders[index].copyWith(currentStep: newStep);
      ongoingOrders[index] = updatedOrder;
    }
  }
}

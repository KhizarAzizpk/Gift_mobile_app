import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderTrackerController extends GetxController {
  final Map<String, Timer> _timers = {};

  void startTracking(OrderModel order) {
    if (_timers.containsKey(order.orderId)) return;

    Timer timer = Timer.periodic(Duration(minutes:5 ), (t) async {
      if (order.currentStep < 3) {
        order.currentStep++;

        // Update currentStep in Firestore
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(order.orderId)
            .update({'currentStep': order.currentStep});
      } else {
        stopTracking(order.orderId);
      }
    });

    _timers[order.orderId] = timer;
  }

  void stopTracking(String orderId) {
    _timers[orderId]?.cancel();
    _timers.remove(orderId);
  }

  @override
  void onClose() {
    for (var timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    super.onClose();
  }
}

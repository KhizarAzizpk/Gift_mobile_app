import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gift_mobile_app/models/newproduct_model.dart';
import 'package:gift_mobile_app/views/search%20gift%20ai%20screen/search_gift_ai_screen.dart';

import '../../models/order_model.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final Product order;

  const OrderConfirmationScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text('Thank you for your order!', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Order ID: ${order.id}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: ()=> Get.to(() => SearchGiftAiScreen()),
              child: const Text("Done")
            ),

          ],
        ),
      ),
    );
  }
}

class MyOrdersScreen {
}

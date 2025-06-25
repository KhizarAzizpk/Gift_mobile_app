import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/cart_controller.dart';
import 'package:gift_mobile_app/controllers/controllers.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/views/checkout%20scree/order_confirmation.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

import '../../controllers/order_controller.dart';
import '../../models/newproduct_model.dart';
import '../../models/order_model.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final profileController = Get.find<ProfileController>();
    final orderController = Get.find<OrderController>();
    final item = cartController.selectedItems.first;
    debugPrint("here is the text for ${profileController.addressController.value.text}");

    return Scaffold(
      appBar: CustomAppBar(
        title: "Checkout",
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            // Product Card (No Price)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      item.imagePath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.urbanistBold16Black,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Quantity: ${item.count}",
                          style: AppStyle.urbanistMedium12Gray,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Delivery Address Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style: AppStyle.urbanistBold16Black,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${profileController.fullNameController.value.text}\n"
                    "${profileController.addressController.value.text}\n"
                    "${profileController.cityStateController.value.text}\n"
                    "${profileController.postalCodeController.value.text}",

                    style: AppStyle.urbanistMedium12Gray,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${profileController.phoneController.value.text}",
                    style: AppStyle.urbanistMedium12Gray,
                  ),
                ],
              ),
            ),
            kGap12,
            // Summary Section
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(14),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(14),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text("Order Summary", style: AppStyle.urbanistBold16Black),
            //       kGap12,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Item Price", style: AppStyle.urbanistMedium12Gray),
            //           Text("PKR ${item.price * item.count}", style: AppStyle.urbanistMedium14Black), //200 is hardcoded price to test the ui
            //         ],
            //       ),
            //       kGap6,
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Delivery Charges", style: AppStyle.urbanistMedium12Gray),
            //           Text("PKR 200", style: AppStyle.urbanistMedium14Black),
            //         ],
            //       ),
            //       Divider(height: 24, thickness: 1, color: Colors.grey.shade300),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("Total", style: AppStyle.urbanistBold16Black),
            //           Text(
            //             "PKR ${( item.price * item.count) + 200}", //later i have to add item price in here
            //             style: AppStyle.urbanistBold16Black,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            kGap12,



            const SizedBox(height: 100,),

           // Place Order Button
            CommonElevatedButton(
              text: "Place Order",
              elevation: 0.0,
              borderRadius: 50,
              width: double.infinity,
              style: AppStyle.urbanistBold16White,
              onPressed: () async {
                //placing order logic here ...
                final cartController = Get.find<CartController>();
                final item = cartController.selectedItems.first;
                cartController.removeCartProduct(item);



                // final order = OrderModel(
                //   orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                //   productId: item.id,
                //   title: item.title,
                //   image: item.imagePath,
                //   price: item.price * item.count,
                //   ratings: item.rating ?? 0.0,
                //   // description: item.description,
                //   isCompleted: false,
                //   timestamp: DateTime.now(),
                //   currentStep: 0,
                //   quantity: item.count,
                //
                // );
                //
                // await cartController.placeOrder(order);
                final order = Product(
                  id: item.id,
                  title: item.title,
                  image: item.imagePath,
                  price: item.price,
                  ratings: item.rating ?? 0.0,
                  quantity: item.count,
                  description: '', // if available
                );

                await orderController.addOrderToFirestore(order);
                
                await cartController.updateCartInFirestore();
                Get.snackbar("Order placed", "Your order has been placed succesfully",
                colorText: Colors.white,
                  backgroundColor: Colors.amberAccent,
                );

                //Optionally navigate back or to order confirmation screen
               Get.to(()=>OrderConfirmationScreen(order: order));


              },
            ),
          ],
        ),
      ),
    );
  }
}

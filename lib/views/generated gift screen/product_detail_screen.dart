import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gift_mobile_app/models/cart_model.dart';
import 'package:gift_mobile_app/models/newproduct_model.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_network_image.dart';

import 'package:gift_mobile_app/widgets/custom_text.dart';
import 'package:gift_mobile_app/widgets/custom_textField.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../utils/constants/app_assets.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});

  final cartcontroller = Get.put(CartController());

  TextEditingController MessageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final Product product = Get.arguments as Product;
    // TODO: implement build
    return Scaffold( backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Product Details",
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Container(
                height: 320.h,
                width: 460.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomNetworkImage(
                  imageUrl: product.image,
                  boxFit: BoxFit.cover,
                )),
            kGap12,
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CustomText(
                  text: product.title, style: AppStyle.montserratBoldBlack16),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20, top: 10, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      _showCartPopup(context);


                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: CustomTextFormField(
                courserColor: Colors.grey,
                controller: MessageController,
                hintText: "Write A message to your Beloved one",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
            kGap40,
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CommonElevatedButton(
                    shadowColor: Colors.transparent,
                    text: "Place The Order",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final OrderController orderController =
                          Get.find<OrderController>();
                      orderController.addOrderToFirestore(product);

                      Get.snackbar(
                        "Success",
                        "Order Placed Successfully",
                        colorText: Colors.white,
                        backgroundColor: Colors.greenAccent,
                        snackPosition: SnackPosition.TOP,
                      );
                    }),
              ),
            ),
            kGap80,
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CommonElevatedButton(
                    shadowColor: Colors.transparent,
                    text: "Add Payment Method",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showPaymentPopup(context);
                    }),
              ),
            ),
            kGap20,
          ],
        ),
      ),
    );
  }

  void _showPaymentPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text("Add Payment Method"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextFormField(
                    controller: cardNumberController,
                    labelText: "Card Number",
                    hintText: "Enter card number",
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.credit_card),
                    validator: (value) =>
                        value!.isEmpty ? "Enter card number" : null,
                  ),
                  kGap8,
                  CustomTextFormField(
                    controller: expiryDateController,
                    labelText: "Expiry Date",
                    hintText: "MM/YY",
                    keyboardType: TextInputType.datetime,
                    prefixIcon: Icon(Icons.calendar_today),
                    validator: (value) =>
                        value!.isEmpty ? "Enter expiry date" : null,
                  ),
                  kGap8,
                  CustomTextFormField(
                    controller: cvvController,
                    labelText: "CVV",
                    hintText: "Enter CVV",
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock),
                    validator: (value) => value!.isEmpty ? "Enter CVV" : null,
                  ),
                  kGap8,
                  CustomTextFormField(
                    controller: cardHolderNameController,
                    labelText: "Cardholder Name",
                    hintText: "Enter cardholder name",
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.person),
                    validator: (value) =>
                        value!.isEmpty ? "Enter cardholder name" : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Payment method added successfully!")),
                  );
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showCartPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(20),
          content: SizedBox(
            height: 180,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add item to your cart?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Do you want to add this product to your cart?',
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel Button
                    Container(
                      height: 45,width: 130,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Add Button
                    Container(
                      height: 45,width: 130,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          CartModel Cartitem = CartModel(
                               id: product.id,
                              imagePath: product.image,
                              title: product.title,
                              colorIconPath: "",
                              color: "",
                              count: 1,
                              rating: product.ratings,
                          price: product.price,
                          );
                          cartcontroller.addToCart(Cartitem);

                          Get.snackbar(
                            "Cart",
                            "Item added to cart",
                            backgroundColor: Colors.amber,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          Navigator.pop(context); // Close dialog
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),

                          ),
                        ),
                        child: const Text('Add',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}


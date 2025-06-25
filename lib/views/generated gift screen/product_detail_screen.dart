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
                      if(cardNumberController.text.isEmpty  ||
                      expiryDateController.text.isEmpty||
                      cvvController.text.isEmpty||
                      cardNumberController.text.isEmpty){
                        Get.snackbar("Add payment method first", "please add payment method first before placing the order",colorText: Colors.white,backgroundColor: Colors.amber[700]);
                      return ;
                      }

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
                      showPaymentPopup(context);
                    }),
              ),
            ),
            kGap20,
          ],
        ),
      ),
    );
  }


  // void _showPaymentPopup(BuildContext context) {
  //   final screenWidth = MediaQuery.of(context).size.width;
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 24), // padding around dialog
  //         child: Container(
  //           width: screenWidth * 0.95, // now it will actually respect this
  //           constraints: BoxConstraints(maxHeight: 330), // shorter
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //           child: Form(
  //             key: _formKey,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const Text(
  //                   "Add Payment Method",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(height: 12),
  //
  //                 CustomTextFormField(
  //                   controller: cardNumberController,
  //                   labelText: "Card Number",
  //                   hintText: "Enter card number",
  //                   keyboardType: TextInputType.number,
  //                   prefixIcon: Icon(Icons.credit_card),
  //                   validator: (value) =>
  //                   value!.isEmpty ? "Enter card number" : null,
  //                 ),
  //                 const SizedBox(height: 8),
  //
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: CustomTextFormField(
  //                         controller: expiryDateController,
  //                         labelText: "Expiry Date",
  //                         hintText: "MM/YY",
  //                         keyboardType: TextInputType.datetime,
  //                         prefixIcon: Icon(Icons.calendar_today),
  //                         validator: (value) =>
  //                         value!.isEmpty ? "Enter expiry date" : null,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 12),
  //                     Expanded(
  //                       child: CustomTextFormField(
  //                         controller: cvvController,
  //                         labelText: "CVV",
  //                         hintText: "Enter CVV",
  //                         keyboardType: TextInputType.number,
  //                         obscureText: true,
  //                         prefixIcon: Icon(Icons.lock),
  //                         validator: (value) =>
  //                         value!.isEmpty ? "Enter CVV" : null,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //
  //                 CustomTextFormField(
  //                   controller: cardHolderNameController,
  //                   labelText: "Cardholder Name",
  //                   hintText: "Enter cardholder name",
  //                   keyboardType: TextInputType.text,
  //                   prefixIcon: Icon(Icons.person),
  //                   validator: (value) =>
  //                   value!.isEmpty ? "Enter cardholder name" : null,
  //                 ),
  //                 const SizedBox(height: 20),
  //
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () => Navigator.pop(context),
  //                       child: const Text("Cancel"),
  //                     ),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         if (_formKey.currentState!.validate()) {
  //                           Navigator.pop(context);
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             const SnackBar(
  //                               content:
  //                               Text("Payment method added successfully!"),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                       child: const Text("Add"),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void showPaymentPopup(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final TextEditingController cardHolderNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth * 0.95,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Choose Your Payment Method",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),

                    // Payment method icons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/paypal_icon.svg", height: 80, width: 60),
                          const SizedBox(width: 44),
                          SvgPicture.asset("assets/icons/apple_icon.svg", height: 60, width: 60),
                          const SizedBox(width: 44),
                          Image.asset("assets/images/Stripe.png", height: 200, width: 80),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Card Number
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Card Number",
                        prefixIcon: Icon(Icons.credit_card),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? "Please enter card number" : null,
                    ),
                    const SizedBox(height: 12),

                    // Expiry + CVV
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: expiryDateController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              labelText: "Expiry Date",
                              hintText: "MM/YY",
                              prefixIcon: Icon(Icons.date_range),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                            value!.isEmpty ? "Enter expiry date" : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "CVV",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                            value!.isEmpty ? "Enter CVV" : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Cardholder Name
                    TextFormField(
                      controller: cardHolderNameController,
                      decoration: InputDecoration(
                        labelText: "Cardholder Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? "Enter name on card" : null,
                    ),
                    const SizedBox(height: 180),

                    // Buttons
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 220,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Payment Confirmed"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Confirm Payment",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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


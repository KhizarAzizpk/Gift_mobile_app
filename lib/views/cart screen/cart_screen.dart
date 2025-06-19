import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/cart_controller.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/views/checkout%20scree/check_out_screen.dart';
import 'package:gift_mobile_app/widgets/bottom_sheet.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomAppBar(
        title: AppString.myCart,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Obx(() {
        if (cartController.isloading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.greenAccent),
          );
        }

        final cartItems = cartController.cartItems;
        final selectedIds = cartController.selectedCartItemIds;

        if (cartItems.isEmpty) {
          return const Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Column(
              children: List.generate(cartItems.length, (index) {
                var data = cartItems[index];
                bool isSelected = selectedIds.contains(data.id);

                return GestureDetector(
                  onTap: () {
                    cartController.toggleSelectedItem(data.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green.shade50 : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color:
                          isSelected ? Colors.green : Colors.transparent,
                          width: 1.5),
                    ),
                    margin: kPaddAll10,
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              data.imagePath,
                              width: 90.w,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Padding(
                            padding: kPaddAll8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text:
                                        Helper.truncateString(data.title, 18),
                                        style: AppStyle.urbanistBold20Black,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        modalBottomSheetMenu(context, data = data);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                kGap5,
                                Row(
                                  children: [
                                    kGap8,
                                    CustomText(
                                      text: Helper.truncateString(data.color, 30),
                                      style: AppStyle.urbanistMedium12DarkGray,
                                    ),
                                  ],
                                ),
                                kGap8,
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16, color: Colors.orange),
                                    kGap10,
                                    CustomText(
                                      text: data.rating.toString(),
                                      style: AppStyle.urbanistMedium16Gray,
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        cartController.decrementItem(index);
                                      },
                                      child:
                                      const Icon(Icons.remove_circle_outline),
                                    ),
                                    kGap12,
                                    CustomText(
                                      text: data.count.toString(),
                                      style: AppStyle.urbanistBold16Black,
                                    ),
                                    kGap12,
                                    InkWell(
                                      onTap: () {
                                        cartController.incrementItem(index);
                                      },
                                      child:
                                      const Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                                if (isSelected) ...[
                                  kGap8,
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.check_circle,
                                            color: Colors.green, size: 20),
                                        kGap5,
                                        const Text("Selected",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      }),
      floatingActionButton: CommonElevatedButton(
        text: AppString.checkout,
        elevation: 0.0,
        borderRadius: 50,
        width: 372.w,
        style: AppStyle.urbanistBold16White,
        onPressed: () {
          final cartController = Get.find<CartController>();
          cartController.prepareSelectedItems();
          if (cartController.selectedItems.isNotEmpty) {
            final selected = cartController.selectedItems.first;
            debugPrint("✅ Selected item for checkout:");
            debugPrint("Title: ${selected.title}");
            debugPrint("Price is ${selected.price}");
            debugPrint("ID: ${selected.id}");
            debugPrint("Count: ${selected.count}");
          }

          if (cartController.selectedItems.isEmpty) {
            final selected = cartController.selectedItems.first;
            debugPrint('Title${selected.title}');
            if (cartController.selectedItems.isEmpty) {
    Get.snackbar(
    "No Items Selected",
    "Please tap on items to select for checkout",
    backgroundColor: Colors.redAccent,
    colorText: Colors.white,
    );
    return;
    }
          }
          // Get.to(CheckoutScreen());


         Get.toNamed("/add-address-screen");
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/cart_controller.dart';
import 'package:gift_mobile_app/main.dart';
import 'package:gift_mobile_app/models/cart_model.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';
void modalBottomSheetMenu(
    BuildContext context,
    var data,
    )
{
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (builder) {
      return Container(
        height: 380.h,
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                kGap12,
                const CustomText(
                  text: AppString.removeFromCart,
                  style: AppStyle.urbanistBold20Black,
                ),
                kGap12,
                const Divider(thickness: 0.5, color: kGrayColor),
                kGap8,
                Row(
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
                        child: data.imagePath.toString().startsWith("http")
                            ? Image.network(
                          data.imagePath,
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                        )
                            : Image.asset(
                          data.imagePath,
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: data.title,
                            style: AppStyle.urbanistBold16Black,
                          ),
                          kGap5,
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: const CustomAssetsImage(
                                  imagePath:
                                  Assets.assetsIconsGrayColorIcon,
                                  boxFit: BoxFit.contain,
                                ),
                              ),
                              kGap8,
                              Expanded(
                                child: CustomText(
                                  text: Helper.truncateString(
                                    AppString.color,
                                    30,
                                  ),
                                  style: AppStyle.urbanistMedium12DarkGray,
                                ),
                              ),
                            ],
                          ),
                          kGap8,
                          Row(
                            children: [
                              const CustomAssetsImage(
                                imagePath: Assets.assetsIconsRatingStarIcon,
                                boxFit: BoxFit.contain,
                              ),
                              kGap10,
                              const CustomText(
                                text: AppString.rating,
                                style: AppStyle.urbanistMedium16Gray,
                              ),
                              const Spacer(),

                              // ➖ Minus button
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: CustomAssetsImage(
                                      imagePath: Assets.assetsIconsMinusIconBlack,
                                      width: 12,
                                      height: 2,
                                      boxFit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              kGap12,

                              // Quantity
                              CustomText(
                                text: data.count.toString(),
                                style: AppStyle.urbanistBold16Black,
                              ),
                              kGap12,

                              // ➕ Plus button
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: CustomAssetsImage(
                                      imagePath: Assets.assetsIconsPlusIconBlack,
                                      height: 12,
                                      width: 12,
                                      boxFit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                kGap12,
                const Divider(thickness: 0.5, color: kGrayColor),
                kGap12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CommonElevatedButton(
                      text: AppString.cancel,
                      height: 52.h,
                      elevation: 0.0,
                      borderRadius: 50,
                      buttonColor: kGrayColor,
                      style: AppStyle.urbanistBold14Black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CommonElevatedButton(
                      text: AppString.yesRemove,
                      height: 52.h,
                      elevation: 0.0,
                      borderRadius: 50,
                      style: AppStyle.urbanistBold14White,
                      onPressed: () {
                        // Handle removal here
                        final CartController cartcontroller = Get.find<CartController>();

                        CartModel cartitem = CartModel(
                          id:  data.id,
                            imagePath: data.imagePath, title: data.title, colorIconPath: "", color: "", count: 1, rating: data.rating,price: data.price);
                        cartcontroller.removeCartProduct(cartitem);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


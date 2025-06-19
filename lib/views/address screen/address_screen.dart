import 'package:flutter/material.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

import '../../utils/constants/app_assets.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: AppString.address,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // Add some padding for spacing
          child: Column(
            children: [
              kGap50,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Aligns items to the top
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CustomAssetsImage(
                        imagePath: Assets.assetsImagesAddressImage),
                  ),
                  const SizedBox(width: 10),
                  // Space between image and text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Home",
                              style: AppStyle.montserratBoldBlack16,
                            ),
                            const SizedBox(width: 10),
                            // Space between text and button
                            Container(
                              height: 23,
                              width: 58,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: CommonElevatedButton(
                                text: "Default",
                                style:
                                    TextStyle(fontSize: 8, color: Colors.black),
                                onPressed: () {},
                                buttonColor: Color(0xff10101014),
                              ),
                            ),
                          ],
                        ),
                        kGap8,
                        CustomText(
                          text: "61480 Sunbrook Park, PC 5679",
                          style:
                              TextStyle(color: Color(0xff616161), fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAssetsImage(
                      imagePath: Assets.assetsImagesEdit,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              kGap50,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Aligns items to the top
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CustomAssetsImage(
                        imagePath: Assets.assetsImagesAddressImage),
                  ),
                  const SizedBox(width: 10),
                  // Space between image and text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Office",
                              style: AppStyle.montserratBoldBlack16,
                            ),
                          ],
                        ),
                        kGap8,
                        CustomText(
                          text: "6993 Meadow Valley Terra, PC 3637",
                          style:
                              TextStyle(color: Color(0xff616161), fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAssetsImage(
                      imagePath: Assets.assetsImagesEdit,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              kGap50,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Aligns items to the top
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CustomAssetsImage(
                        imagePath: Assets.assetsImagesAddressImage),
                  ),
                  const SizedBox(width: 10),
                  // Space between image and text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Apartment",
                              style: AppStyle.montserratBoldBlack16,
                            ),
                          ],
                        ),
                        kGap8,
                        CustomText(
                          text: "21833 Clyde Gallagher, PC 4662",
                          style:
                              TextStyle(color: Color(0xff616161), fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAssetsImage(
                      imagePath: Assets.assetsImagesEdit,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              kGap50,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Aligns items to the top
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CustomAssetsImage(
                        imagePath: Assets.assetsImagesAddressImage),
                  ),
                  const SizedBox(width: 10),
                  // Space between image and text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Parent's House",
                              style: AppStyle.montserratBoldBlack16,
                            ),
                          ],
                        ),
                        kGap8,
                        CustomText(
                          text: "5259 Blue Bill Park, PC 4627",
                          style:
                              TextStyle(color: Color(0xff616161), fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAssetsImage(
                      imagePath: Assets.assetsImagesEdit,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              kGap50,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Aligns items to the top
                children: [
                  Container(
                    width: 57,
                    height: 57,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CustomAssetsImage(
                        imagePath: Assets.assetsImagesAddressImage),
                  ),
                  const SizedBox(width: 10),
                  // Space between image and text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Town Square",
                              style: AppStyle.montserratBoldBlack16,
                            ),
                          ],
                        ),
                        kGap8,
                        CustomText(
                          text: "5375 Summerhouse, PC 4627",
                          style:
                              TextStyle(color: Color(0xff616161), fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CustomAssetsImage(
                      imagePath: Assets.assetsImagesEdit,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              kGap120,
              Container(
                  height: 50,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CommonElevatedButton(
                    text: "Add New Address",
                    style: AppStyle.montserratMediumWhite14,
                    onPressed: () {},
                    shadowColor: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

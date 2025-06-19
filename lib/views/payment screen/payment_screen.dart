import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

import '../../utils/constants/app_assets.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: CustomAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22.0, top: 8),
              child: CustomAssetsImage(
                imagePath: Assets.assets3Dots,
                width: 26,
                height: 26,
              ),
            ),
          ],
          title: AppString.payment,
          elevation: 0,
          titleStyle: AppStyle.urbanistBold24Black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 55.0, right: 55, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomAssetsImage(
                        imagePath: Assets.assetsIconsPaypalIcon,
                        width: 24,
                        height: 24,
                      ),
                      kGap14,
                      CustomText(
                        text: "Paypal",
                        style: AppStyle.urbanistBold20Black,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Connected",
                    style: AppStyle.urbanistBold16Black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0, right: 55, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomAssetsImage(
                        imagePath: Assets.assetsIconsGoogleIcon,
                        width: 24,
                        height: 24,
                      ),
                      kGap14,
                      CustomText(
                        text: "Google Pay",
                        style: AppStyle.urbanistBold20Black,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Connected",
                    style: AppStyle.urbanistBold16Black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0, right: 55, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomAssetsImage(
                        imagePath: Assets.assetsIconsAppleIcon,
                        width: 24,
                        height: 24,
                      ),
                      kGap14,
                      CustomText(
                        text: "Apple Pay",
                        style: AppStyle.urbanistBold20Black,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Connected",
                    style: AppStyle.urbanistBold16Black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0, right: 55, top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomAssetsImage(
                        imagePath: Assets.assetsIconsMasterCardIcon,
                        width: 24,
                        height: 24,
                      ),
                      kGap14,
                      CustomText(
                        text: "•••• •••• •••• •••• 4679",
                        style: AppStyle.urbanistBold20Black,
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Connected",
                    style: AppStyle.urbanistBold16Black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Container(
                  height: 56,
                  width: 365,
                  child: CommonElevatedButton(
                      text: "Add New Card",
                      style: AppStyle.montserratMediumWhite14,
                      onPressed: () {})),
            ), //ElevatedButton
          ],
        ));
  }
}

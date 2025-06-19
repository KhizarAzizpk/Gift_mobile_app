import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

import '../../utils/constants/app_assets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: const CustomAppBar(
          title: AppString.notification,
          elevation: 0,
          titleStyle: AppStyle.urbanistBold24Black,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "General Notification",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Sound",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Vibrate",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Special Offers",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Promo & Discount",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Payments",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Cashback",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "App Updates",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "New Service Available",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  CustomAssetsImage(
                    imagePath: Assets.assetsFrame,
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "New Tips Available",
                    style: AppStyle.urbanistBold20Black,
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: CustomAssetsImage(
                        imagePath: Assets.assetsFrame,
                        width: 20,
                        height: 20,
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}

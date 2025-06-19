import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';

class Helper {
  static showCommonProcessingDialog({
    required String message,
  }) {
    return Get.dialog(
      AlertDialog.adaptive(
        title: const Text(
          'Processing',
          textAlign: TextAlign.center,
          textScaler: TextScaler.noScaling,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColor.kPrimaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              textScaler: TextScaler.noScaling,
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showErrorDialog(String error) {
    Get.dialog(
      AlertDialog.adaptive(
        title: const Text('Error'),
        content: Text(error),
        actions: [
          CommonElevatedButton(
            text: 'OK',
            textColor: Colors.black,
            buttonColor: AppColor.kPrimaryColor,
            width: 80.0,
            height: 30.0,
            style: AppStyle.montserratBoldWhite16,
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  showCommonAlertDialog({
    required String title,
    required String message,
  }) {
    return Get.dialog(
      AlertDialog.adaptive(
        title: Text(
          title,
          textAlign: TextAlign.center,
          textScaler: TextScaler.noScaling,
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          textScaler: TextScaler.noScaling,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: kWhiteColor,
        actions: [
          Center(
            child: CommonElevatedButton(
              onPressed: () {
                Get.back();
              },
              text: 'OK',
              style: AppStyle.montserratBoldWhite16,
              buttonColor: Colors.black,
              height: 40,
              width: 100,
            ),
          )
        ],
      ),
    );
  }

  static String truncateString(String text, int maxLength) {
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}

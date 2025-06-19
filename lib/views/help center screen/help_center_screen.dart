import 'package:flutter/material.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomAppBar(
        title: AppString.helpCenter,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: Center(
          child: CustomText(
        text: "Help Center Under Development",
        style: AppStyle.urbanistBold20Black,
      )),
    );
  }
}

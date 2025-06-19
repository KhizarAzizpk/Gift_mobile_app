import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/controllers.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/views/checkout%20scree/check_out_screen.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_app_bar.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';
import 'package:gift_mobile_app/widgets/custom_textField.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: AppString.addAnAddresstoOrder,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kPaddAll18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: CustomText(
                  text: "Full Name",
                  style: AppStyle.urbanistBold16Black,
                ),
              ),
              kGap6,
              CustomTextFormField(
                borderRadius: 20,
                hintText: "Enter Full name",
                style: AppStyle.urbanistSemiBold14Black,
                hintStyle: AppStyle.urbanistSemiBold14Gray,
                focusedBorderColor: kBlackColor,
                courserColor: kBlackColor,
                controller: profileController.fullNameController.value,
              ),
              kGap10,
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: CustomText(
                  text: "Phone number",
                  style: AppStyle.urbanistBold16Black,
                ),
              ),
              kGap6,
              CustomTextFormField(
                borderRadius: 20,
                hintText: "USA+1",
                style: AppStyle.urbanistSemiBold14Black,
                hintStyle: AppStyle.urbanistSemiBold14Gray,
                focusedBorderColor: kBlackColor,
                courserColor: kBlackColor,
                controller: profileController.phoneController.value,
              ),
              kGap10,
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: CustomText(
                  text: "State, city",
                  style: AppStyle.urbanistBold16Black,
                ),
              ),
              kGap6,
              CustomTextFormField(
                borderRadius: 20,
                hintText: "Select",
                style: AppStyle.urbanistSemiBold14Black,
                hintStyle: AppStyle.urbanistSemiBold14Gray,
                focusedBorderColor: kBlackColor,
                courserColor: kBlackColor,
                controller: profileController.cityStateController.value,
              ),
              kGap10,
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: CustomText(
                  text: "Address",
                  style: AppStyle.urbanistBold16Black,
                ),
              ),
              kGap6,
              CustomTextFormField(
                borderRadius: 20,
                hintText: "Select, building, house number",
                style: AppStyle.urbanistSemiBold14Black,
                hintStyle: AppStyle.urbanistSemiBold14Gray,
                focusedBorderColor: kBlackColor,
                courserColor: kBlackColor,
                controller: profileController.addressController.value,
              ),
              kGap10,
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: CustomText(
                  text: "Postal code",
                  style: AppStyle.urbanistBold16Black,
                ),
              ),
              kGap6,
              CustomTextFormField(
                borderRadius: 20,
                hintText: "Enter a 5+digit number",
                style: AppStyle.urbanistSemiBold14Black,
                hintStyle: AppStyle.urbanistSemiBold14Gray,
                focusedBorderColor: kBlackColor,
                courserColor: kBlackColor,
                controller: profileController.postalCodeController.value,
              ),
              kGap160
            ],
          ),
        ),
      ),
      floatingActionButton: CommonElevatedButton(
        text: AppString.continuetoPayment,
        elevation: 0.0,
        borderRadius: 50,
        width: 372.w,
        style: AppStyle.urbanistBold16White,
        onPressed: () {
          profileController.updateUser(
            fullName: profileController.fullNameController.value.text,
            email: profileController.emailController.value.text,
            phone: profileController.phoneController.value.text,
            dob: profileController.dateofbirthController.value.text,
            gender: "",
            selectedCountry: "",
            country: "USA",
            address: profileController.addressController.value.text,
            cityState: profileController.cityStateController.value.text,
            postalCode: profileController.postalCodeController.value.text,
          );
          Get.to(CheckoutScreen());

          // Get.toNamed("/payment-methods-screen");
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/login_controller.dart';
import 'package:gift_mobile_app/controllers/signup_controller.dart';
import 'package:gift_mobile_app/utils/constants/app_assets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';
import 'package:gift_mobile_app/widgets/custom_textField.dart';

class SignupScreen extends GetView<SignupController> {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: kSH24,
          child: Form(
            key: _formKey,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kGap60,
                  const Text(
                    AppString.createYourAccount,
                    style: AppStyle.urbanistBold48Black,
                  ),
                  kGap30,
                  CustomTextFormField(
                    hintText: AppString.userName,
                    style: AppStyle.urbanistSemiBold14Black,
                    hintStyle: AppStyle.urbanistSemiBold14Gray,
                    prefixIcon: const Padding(
                      padding: kPaddAll8,
                      child: CustomAssetsImage(
                        imagePath: Assets.assetsIconsProfileIconBlack,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    focusedBorderColor: kBlackColor,
                    courserColor: kBlackColor,
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    controller: controller.userNameController.value,
                  ),
                  kGap16,
                  CustomTextFormField(
                    hintText: AppString.email,
                    style: AppStyle.urbanistSemiBold14Black,
                    hintStyle: AppStyle.urbanistSemiBold14Gray,
                    prefixIcon: const Padding(
                      padding: kPaddAll8,
                      child: CustomAssetsImage(
                        imagePath: Assets.assetsIconsMailIconBlack,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    focusedBorderColor: kBlackColor,
                    courserColor: kBlackColor,
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    controller: controller.emailController.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Email is invalid';
                      }
                      return null;
                    },
                  ),
                  kGap16,
                  CustomTextFormField(
                    hintText: AppString.password,
                    obscureText: controller.isPasswordVisible.value,
                    hintStyle: AppStyle.urbanistSemiBold14Gray,
                    prefixIcon: const Padding(
                      padding: kPaddAll8,
                      child: CustomAssetsImage(
                        imagePath: Assets.assetsIconsLockIconBlack,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    focusedBorderColor: kBlackColor,
                    courserColor: kBlackColor,
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => controller.togglePasswordVisibility(),
                      child: const Padding(
                        padding: kPaddAll8,
                        child: CustomAssetsImage(
                          imagePath: Assets.assetsIconsEyeOffIconBlack,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    controller: controller.passwordController.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is Required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  kGap16,
                  CustomTextFormField(
                    hintText: AppString.cpassword,
                    obscureText: controller.isConfirmPasswordVisible.value,
                    hintStyle: AppStyle.urbanistSemiBold14Gray,
                    prefixIcon: const Padding(
                      padding: kPaddAll8,
                      child: CustomAssetsImage(
                        imagePath: Assets.assetsIconsLockIconBlack,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    focusedBorderColor: kBlackColor,
                    courserColor: kBlackColor,
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    suffixIcon: InkWell(
                      onTap: () => controller.toggleConfirmPasswordVisibility(),
                      child: const Padding(
                        padding: kPaddAll8,
                        child: CustomAssetsImage(
                          imagePath: Assets.assetsIconsEyeOffIconBlack,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 35.w,
                      minHeight: 35.h,
                      maxWidth: 38.w,
                      maxHeight: 38.h,
                    ),
                    controller: controller.confrirmController.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is Required';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  kGap40,
                  controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kBlackColor,
                        ))
                      : CommonElevatedButton(
                          text: AppString.signup,
                          elevation: 0.0,
                          borderRadius: 50,
                          width: double.infinity,
                          style: AppStyle.urbanistBold16White,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (controller.passwordController.value.text !=
                                  controller.confrirmController.value.text) {
                                Get.snackbar(
                                  'Error',
                                  'Password and Confirm Password not match',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              } else {
                                controller.userModel.value.userName =
                                    controller.userNameController.value.text;
                                controller.userModel.value.email =
                                    controller.emailController.value.text;

                                await controller.registerUser(
                                    userModel: controller.userModel.value);
                              }
                            }
                          },
                        ),
                  kGap30,
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomText(
                          text: AppString.orContinueWith,
                          style: AppStyle.urbanistSemiBold18Gray,
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  kGap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.facebook,
                          size: 36,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const CustomAssetsImage(
                          imagePath: Assets.assetsIconsGoogleIcon,
                          width: 28,
                          height: 28,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.apple, size: 36),
                      ),
                    ],
                  ),
                  kGap20,
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed("/login-screen");
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: AppString.alreadyhaveanaccountLogin,
                          style: AppStyle.urbanistRegular14Gray,
                        ),
                        kGap10,
                        CustomText(
                          text: AppString.login,
                          style: AppStyle.urbanistSemiBold14Black,
                        ),
                      ],
                    ),
                  ),
                  kGap16,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

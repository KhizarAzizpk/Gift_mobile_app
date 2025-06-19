import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/home_controller.dart';
import 'package:gift_mobile_app/controllers/login_controller.dart';
import 'package:gift_mobile_app/utils/constants/app_assets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';
import 'package:gift_mobile_app/widgets/custom_textField.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());
  var homeController = Get.put(HomeController());

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
                  kGap100,
                  const Text(
                    AppString.loginToYourAccount,
                    style: AppStyle.urbanistBold48Black,
                  ),
                  kGap40,
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
                  ),
                  kGap16,
                  Row(
                    children: [
                      Checkbox(
                          value: controller.isRememberMe.value,
                          activeColor: kBlackColor,
                          onChanged: (value) {
                            controller.toggleRememberMe();
                          }),
                      const CustomText(
                        text: AppString.rememberMe,
                        style: AppStyle.urbanistSemiBold14Black,
                      ),
                    ],
                  ),
                  kGap16,
                  controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: kBlackColor,
                          ),
                        )
                      : CommonElevatedButton(
                          text: AppString.login,
                          elevation: 0.0,
                          borderRadius: 50,
                          width: double.infinity,
                          style: AppStyle.urbanistBold16White,
                          onPressed: () async {

                            if (_formKey.currentState!.validate()) {
                              await controller.loginUser(
                                  email: controller.emailController.value.text,
                                  password:
                                      controller.passwordController.value.text);
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
                  kGap50,
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed("/signup-screen");
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: AppString.dontHaveAnaAccountRegister,
                          style: AppStyle.urbanistRegular14Gray,
                        ),
                        kGap10,
                        CustomText(
                          text: AppString.signup,
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

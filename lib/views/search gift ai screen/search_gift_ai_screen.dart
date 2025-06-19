import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/home_controller.dart';
import 'package:gift_mobile_app/controllers/search_gift_controller.dart';
import 'package:gift_mobile_app/utils/constants/app_assets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/widgets/common_elevated_button.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';
import 'package:gift_mobile_app/widgets/custom_textField.dart';
import 'package:group_button/group_button.dart';

import '../../models/user_model.dart';

class SearchGiftAiScreen extends GetView<SearchGiftController> {
  SearchGiftAiScreen({super.key});

  final searchController = SearchGiftController();
  final groupButtonController = GroupButtonController();
  final homeController = Get.put(HomeController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? interested;
  String? notInterested;
  String? theme;
  String? occasion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kGap30,
            Padding(
              padding: kPaddAll14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomAssetsImage(
                    imagePath: Assets.assetsIconsGiftShopIcon,
                    width: 90,
                    height: 50,
                    boxFit: BoxFit.contain,
                  ),
                  Row(
                    children: [
                      const CustomAssetsImage(
                        imagePath: Assets.assetsIconsLocationPickIconBlack,
                        boxFit: BoxFit.contain,
                        width: 23,
                        height: 23,
                      ),
                      kGap5,
                      InkWell(
                        onTap: () {},
                        child: const CustomText(
                          text: AppString.locationText,
                          style: TextStyle(fontSize: 8),
                        ),
                      ),
                      kGap12,
                      InkWell(
                        onTap: () {},
                        child: const CustomAssetsImage(
                          imagePath: Assets.assetsIconsBellIconBlack,
                          boxFit: BoxFit.contain,
                          width: 23,
                          height: 23,
                        ),
                      ),
                      kGap10,
                      InkWell(
                        onTap: () {},
                        child: const CustomAssetsImage(
                          imagePath: Assets.assetsIconsFavIconBlack,
                          boxFit: BoxFit.contain,
                          width: 23,
                          height: 23,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CustomText(
                text: AppString.generateThePerfectGiftforKids,
                style: AppStyle.urbanistBold20Black,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomText(
                text: AppString.recommendation,
                style: AppStyle.urbanistMedium14Black,
              ),
            ),
            kGap8,
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: CustomTextFormField(
                controller: nameController,
                onChanged: (value) => searchController.name.value = value,
                hintText: "Enter Your Name",
                hintStyle: TextStyle(color: Colors.grey),
                courserColor: Colors.grey,
              ),
            ),
            kGap10,
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: CustomTextFormField(
                controller: dobcontroller,
                onChanged: (value) =>
                    searchController.subProfileModel.value.dateOfBirth = value,
                hintText: "Date Of Birth",
                hintStyle: TextStyle(color: Colors.grey),
                courserColor: Colors.grey,
              ),
            ),
            kGap10,
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: CustomTextFormField(
                controller: emailController,
                onChanged: (value) => searchController.email.value = value,
                hintText: "Enter Email (If Any)",
                hintStyle: TextStyle(color: Colors.grey),
                courserColor: Colors.grey,
              ),
            ),
            kGap20,
            Center(
              child: GroupButton(
                isRadio: true,
                options: GroupButtonOptions(
                  selectedShadow: const [],
                  selectedTextStyle: AppStyle.urbanistBold12White,
                  selectedColor: kBlackColor,
                  unselectedShadow: const [],
                  unselectedColor: kGroupButtonColor,
                  unselectedTextStyle: AppStyle.urbanistBold12Black,
                  selectedBorderColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  buttonHeight: 60,
                  buttonWidth: 160,
                  mainGroupAlignment: MainGroupAlignment.start,
                  crossGroupAlignment: CrossGroupAlignment.start,
                  groupRunAlignment: GroupRunAlignment.start,
                  textAlign: TextAlign.center,
                  textPadding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  elevation: 0,
                ),
                onSelected: (buttonName, index, isSelected) {
                  debugPrint('$buttonName button is selected');
                  controller.subProfileModel.value.interested = buttonName;
                },
                buttons: const [
                  AppString.toys,
                  AppString.books,
                  AppString.clothes,
                  AppString.games,
                  AppString.educational,
                  AppString.musical,
                  AppString.others,
                ],
                buttonBuilder: (selected, buttonText, context) {
                  // Icons list for corresponding buttons
                  final icons = [
                    Icons.toys, // For Toys
                    Icons.book, // For Books
                    Icons.checkroom, // For Clothes
                    Icons.sports_esports, // For Games
                    Icons.school, // For Educational
                    Icons.music_note, // For Musical
                    Icons.more_horiz, // For Others
                  ];

                  // Get the current index of the button
                  final buttonIndex = const [
                    AppString.toys,
                    AppString.books,
                    AppString.clothes,
                    AppString.games,
                    AppString.educational,
                    AppString.musical,
                    AppString.others,
                  ].indexOf(buttonText);

                  return Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selected ? kBlackColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[buttonIndex], // Use corresponding icon
                          color: selected ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: selected
                              ? AppStyle.urbanistBold12White
                              : AppStyle.urbanistBold12Black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            kGap20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomText(
                text: AppString.typeofGiftYouDontWant,
                style: AppStyle.urbanistBold16Black,
              ),
            ),
            kGap20,
            Center(
              child: GroupButton(
                isRadio: true,
                options: GroupButtonOptions(
                  selectedShadow: const [],
                  selectedTextStyle: AppStyle.urbanistBold12White,
                  selectedColor: kBlackColor,
                  unselectedShadow: const [],
                  unselectedColor: kGroupButtonColor,
                  unselectedTextStyle: AppStyle.urbanistBold12Black,
                  selectedBorderColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  buttonHeight: 60,
                  buttonWidth: 160,
                  mainGroupAlignment: MainGroupAlignment.start,
                  crossGroupAlignment: CrossGroupAlignment.start,
                  groupRunAlignment: GroupRunAlignment.start,
                  textAlign: TextAlign.center,
                  textPadding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  elevation: 0,
                ),
                onSelected: (buttonName, index, isSelected) {
                  debugPrint('$buttonName button is selected');
                  controller.subProfileModel.value.notInterested = buttonName;
                },
                buttons: const [
                  AppString.loudToys,
                  AppString.gadgets,
                  AppString.messyItems,
                  AppString.fragile,
                  AppString.others,
                ],
                buttonBuilder: (selected, buttonText, context) {
                  // Icons list for corresponding buttons
                  final icons = [
                    Icons.volume_up, // For Loud Toys
                    Icons.smartphone, // For Gadgets
                    Icons.brush, // For Messy Items
                    Icons.warning, // For Fragile
                    Icons.more_horiz, // For Others
                  ];

                  // Get the current index of the button
                  final buttonIndex = const [
                    AppString.loudToys,
                    AppString.gadgets,
                    AppString.messyItems,
                    AppString.fragile,
                    AppString.others,
                  ].indexOf(buttonText);

                  return Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selected ? kBlackColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[buttonIndex], // Use corresponding icon
                          color: selected ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: selected
                              ? AppStyle.urbanistBold12White
                              : AppStyle.urbanistBold12Black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            kGap20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomText(
                text: AppString.selectTheme,
                style: AppStyle.urbanistBold16Black,
              ),
            ),
            kGap20,
            Center(
              child: GroupButton(
                isRadio: true,
                options: GroupButtonOptions(
                  selectedShadow: const [],
                  selectedTextStyle: AppStyle.urbanistBold12White,
                  selectedColor: kBlackColor,
                  unselectedShadow: const [],
                  unselectedColor: kGroupButtonColor,
                  unselectedTextStyle: AppStyle.urbanistBold12Black,
                  selectedBorderColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  buttonHeight: 60,
                  buttonWidth: 160,
                  mainGroupAlignment: MainGroupAlignment.start,
                  crossGroupAlignment: CrossGroupAlignment.start,
                  groupRunAlignment: GroupRunAlignment.start,
                  textAlign: TextAlign.center,
                  textPadding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  elevation: 0,
                ),
                onSelected: (buttonName, index, isSelected) {
                  debugPrint('$buttonName button is selected');
                  controller.subProfileModel.value.theme = buttonName;
                },
                buttons: const [
                  AppString.cartoons,
                  AppString.animals,
                  AppString.sports,
                  AppString.educational,
                  AppString.others,
                ],
                buttonBuilder: (selected, buttonText, context) {
                  // Icons list for corresponding buttons
                  final icons = [
                    Icons.theater_comedy, // For Cartoons
                    Icons.pets, // For Animals
                    Icons.sports_soccer, // For Sports
                    Icons.school, // For Educational
                    Icons.more_horiz, // For Others
                  ];

                  // Get the current index of the button
                  final buttonIndex = const [
                    AppString.cartoons,
                    AppString.animals,
                    AppString.sports,
                    AppString.educational,
                    AppString.others,
                  ].indexOf(buttonText);

                  return Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selected ? kBlackColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[buttonIndex], // Use corresponding icon
                          color: selected ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: selected
                              ? AppStyle.urbanistBold12White
                              : AppStyle.urbanistBold12Black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            kGap20,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: CustomText(
                text: AppString.selectOccasion,
                style: AppStyle.urbanistBold16Black,
              ),
            ),
            kGap20,
            Center(
              child: GroupButton(
                isRadio: true,
                options: GroupButtonOptions(
                  selectedShadow: const [],
                  selectedTextStyle: AppStyle.urbanistBold12White,
                  selectedColor: kBlackColor,
                  unselectedShadow: const [],
                  unselectedColor: kGroupButtonColor,
                  unselectedTextStyle: AppStyle.urbanistBold12Black,
                  selectedBorderColor: Colors.transparent,
                  unselectedBorderColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  buttonHeight: 60,
                  buttonWidth: 160,
                  mainGroupAlignment: MainGroupAlignment.start,
                  crossGroupAlignment: CrossGroupAlignment.start,
                  groupRunAlignment: GroupRunAlignment.start,
                  textAlign: TextAlign.center,
                  textPadding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  elevation: 0,
                ),
                onSelected: (buttonName, index, isSelected) {
                  debugPrint('$buttonName button is selected');
                  controller.subProfileModel.value.occasion = buttonName;
                },
                buttons: const [
                  AppString.birthday,
                  AppString.christmas,
                  AppString.babyShower,
                  AppString.others,
                ],
                buttonBuilder: (selected, buttonText, context) {
                  // Icons list for corresponding buttons
                  final icons = [
                    Icons.cake, // For Birthday
                    Icons.star, // For Christmas
                    Icons.baby_changing_station, // For Baby Shower
                    Icons.more_horiz, // For Others
                  ];

                  // Get the current index of the button
                  final buttonIndex = const [
                    AppString.birthday,
                    AppString.christmas,
                    AppString.babyShower,
                    AppString.others,
                  ].indexOf(buttonText);

                  return Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                      color: selected ? kBlackColor : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[buttonIndex], // Use corresponding icon
                          color: selected ? Colors.white : Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          buttonText,
                          style: selected
                              ? AppStyle.urbanistBold12White
                              : AppStyle.urbanistBold12Black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            kGap120,
          ],
        ),
      ),
      floatingActionButton: CommonElevatedButton(
        text: AppString.generate,
        elevation: 0.0,
        borderRadius: 50,
        width: 372.w,
        style: AppStyle.urbanistBold16White,
          onPressed: () async {
            print("Here is the selected filter.. ${controller.subProfileModel.value.interested}");
            final model = controller.subProfileModel.value;

            bool noFilterSelected = (model.interested == null || model.interested.isEmpty) &&
                (model.notInterested == null || model.notInterested.isEmpty) &&
                (model.theme == null || model.theme.isEmpty) &&
                (model.occasion == null || model.occasion.isEmpty);

            if (noFilterSelected) {
              Get.snackbar(
                "Missing Selection", "Please select one filter to generate",
                colorText: Colors.black,
                borderRadius: 20.0,
                backgroundColor: Colors.amberAccent[100],
                snackPosition: SnackPosition.BOTTOM,
              );
              return;
            }

            Get.back(); // Close current screen
            Get.dialog(
              const Center(child: CircularProgressIndicator(color: kBlackColor)),
              barrierDismissible: false,
            );

            try {
              final uid = FirebaseAuth.instance.currentUser?.uid;
              debugPrint("User id is $uid");
              if (uid != null) {
                final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                if (userDoc.exists) {
                  final userModel = UserModel.fromMap(userDoc.data()!);
                  debugPrint("userDocData here ${userModel.address}");

                  controller.subProfileModel.value.subProfileId =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  controller.subProfileModel.value.name = nameController.text;
                  controller.subProfileModel.value.dateOfBirth = dobcontroller.text;

                  // Get values from user
                  controller.subProfileModel.value.gender = userModel.gender;
                  controller.subProfileModel.value.address = userModel.address;
                  controller.subProfileModel.value.phone = userModel.phoneNumber;

                  try {
                    final dob = DateTime.tryParse(userModel.dateOfBirth);
                    if (dob != null) {
                      final now = DateTime.now();
                      int age = now.year - dob.year;
                      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
                        age--;
                      }
                      controller.subProfileModel.value.age = age.toString();
                    } else {
                      controller.subProfileModel.value.age = "N/A";
                      print("Invalid DOB format: ${userModel.dateOfBirth}");
                    }
                  } catch (e) {
                    controller.subProfileModel.value.age = "N/A";
                    print("DOB parsing failed: $e");
                  }

                  await controller.addSubProfile(controller.subProfileModel.value);
                  Get.back(); // close loading

                  // Log before navigating
                  print("Navigating with data:");
                  print("Interested: ${model.interested}");
                  print("NotInterested: ${model.notInterested}");
                  print("Theme: ${model.theme}");
                  print("Occasion: ${model.occasion}");

                  try {
                    Get.toNamed("/generated-gift-screen", arguments: {
                      'interested': model.interested,
                      'notInterested': model.notInterested,
                      'theme': model.theme,
                      'occasion': model.occasion,
                    });
                  } catch (e) {
                    print("Navigation failed: $e");
                    Get.snackbar("Navigation Error", "Could not open gift screen.");
                  }

                  Get.snackbar(
                    "Success",
                    "Gift generated successfully!",
                    backgroundColor: Colors.greenAccent,
                    snackPosition: SnackPosition.TOP,
                  );
                }
              }
            } catch (e) {
              Get.back();
              print("Error during gift generation: $e");
              Get.snackbar(
                "Error",
                "Failed to generate gift: $e",
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          }
      ),
    );
  }
}

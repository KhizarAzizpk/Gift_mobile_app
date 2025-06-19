import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/controllers.dart';
import 'package:gift_mobile_app/controllers/profile_controller.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/views/profile%20screen/widgets/build_menu_item.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: AppString.profile,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if(controller.isLoading.value){
              return Center(
                child: CircularProgressIndicator(),
              );
            }


           return   Column(
            children: [
              kGap20,
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                     CircleAvatar(
                      radius: 50,
                      backgroundImage:profileController.imgUrl.value.isNotEmpty
                          ? NetworkImage(profileController.imgUrl.value)
                          : AssetImage(Assets.assetsImagesProfileImage) as ImageProvider,
                    ),
                    Container(
                      height: 35.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: () {

                          profileController.getImage();
                        },
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              kGap10,
              CustomText(
                text: controller.name.value,
                style: AppStyle.urbanistBold24Black,
              ),
              kGap5,
               CustomText(
                text: controller.phone.value,
                style: AppStyle.urbanistSemiBold14Black,
              ),
              kGap10,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Divider(),
              ),
              buildMenuItem(
                icon: Icons.person,
                title: AppString.editProfile,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/edit-profile-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.person,
                title: AppString.editKidsAIProfile,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/edit-kids-profile-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.card_giftcard,
                title: AppString.searchGiftwithAI,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/search-ai-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.location_on,
                title: AppString.address,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/address-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.notifications,
                title: AppString.notification,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/notification-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.payment,
                title: AppString.payment,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/payment-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.security,
                title: AppString.security,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/security-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.language,
                title: AppString.language,
                textStyle: AppStyle.urbanistSemiBold18Black,
                trailing: const CustomText(
                  text: AppString.english,
                  style: AppStyle.urbanistSemiBold12Black,
                ),
                onTap: () {},
              ),
              buildMenuItem(
                icon: Icons.lock,
                title: AppString.privacyPolicy,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/policy-screen");
                },
              ),
              buildMenuItem(
                icon: Icons.help_center,
                title: AppString.helpCenter,
                textStyle: AppStyle.urbanistSemiBold18Black,
                onTap: () {
                  Get.toNamed("/help-screen");
                },
              ),
              buildMenuItem(icon: Icons.logout, title: AppString.logout,textStyle: AppStyle.urbanistSemiBold18Black, onTap: (){
                Get.find<LoginController>().logoutuser();
              }),
            ],
          );},
        ),
      ),
    );
  }
}

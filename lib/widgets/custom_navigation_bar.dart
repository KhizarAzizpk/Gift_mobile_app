import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_mobile_app/utils/constants/app_assets.dart';
import 'package:gift_mobile_app/utils/constants/app_color.dart';
import 'package:gift_mobile_app/utils/constants/app_gap.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/style/app_style.dart';
import 'package:gift_mobile_app/views/cart%20screen/cart_screen.dart';
import 'package:gift_mobile_app/views/generated%20gift%20screen/generated_gift_screen.dart';
import 'package:gift_mobile_app/views/login%20screen/login_screen.dart';
import 'package:gift_mobile_app/views/order%20screen/order_screen.dart';
import 'package:gift_mobile_app/views/profile%20screen/profile_screen.dart';
import 'package:gift_mobile_app/views/search%20gift%20ai%20screen/search_gift_ai_screen.dart';
import 'package:gift_mobile_app/views/signup%20screen/signup_screen.dart';
import 'package:gift_mobile_app/widgets/custom_assets_image.dart';
import 'package:gift_mobile_app/widgets/custom_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    SearchGiftAiScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Scaffold(
          backgroundColor: kWhiteColor,
          body: _children[_currentIndex],
          bottomNavigationBar: SizedBox(
            height: 68.h,
            child: Container(
              decoration: const BoxDecoration(
                color: kWhiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () => onTabTapped(0),
                      child: Column(
                        children: [
                          _currentIndex == 0
                              ? CustomAssetsImage(
                                  imagePath:
                                      Assets.assetsIconsAiSearchIconBlack,
                                  height: 20.h,
                                  width: 18.w,
                                )
                              : CustomAssetsImage(
                                  imagePath: Assets.assetsIconsAiSearchIconGray,
                                  height: 20.h,
                                  width: 18.w,
                                ),
                          kGap4,
                          CustomText(
                              text: AppString.aiSearch,
                              style: _currentIndex == 0
                                  ? AppStyle.urbanistBold12Black
                                  : AppStyle.urbanistMedium12Gray),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => onTabTapped(1),
                      child: Column(
                        children: [
                          _currentIndex == 1
                              ? CustomAssetsImage(
                                  imagePath: Assets.assetsIconsCartIconBlack,
                                  height: 20.h,
                                  width: 18.w,
                                )
                              : CustomAssetsImage(
                                  imagePath: Assets.assetsIconsCartIconGray,
                                  height: 20.h,
                                  width: 18.w,
                                ),
                          kGap4,
                          CustomText(
                              text: AppString.cart,
                              style: _currentIndex == 1
                                  ? AppStyle.urbanistBold12Black
                                  : AppStyle.urbanistMedium12Gray),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => onTabTapped(2),
                      child: Column(
                        children: [
                          _currentIndex == 2
                              ? CustomAssetsImage(
                                  imagePath: Assets.assetsIconsOrderIconBlack,
                                  height: 20.h,
                                  width: 18.w,
                                )
                              : CustomAssetsImage(
                                  imagePath: Assets.assetsIconsOrderIconGray,
                                  height: 20.h,
                                  width: 18.w,
                                ),
                          kGap4,
                          CustomText(
                              text: AppString.orders,
                              style: _currentIndex == 2
                                  ? AppStyle.urbanistBold12Black
                                  : AppStyle.urbanistMedium12Gray),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => onTabTapped(3),
                      child: Column(
                        children: [
                          _currentIndex == 3
                              ? CustomAssetsImage(
                                  imagePath: Assets.assetsIconsProfileIconBlack,
                                  height: 20.h,
                                  width: 18.w,
                                )
                              : CustomAssetsImage(
                                  imagePath: Assets.assetsIconsProfileIconGray,
                                  height: 20.h,
                                  width: 18.w,
                                ),
                          kGap4,
                          CustomText(
                              text: AppString.profile,
                              style: _currentIndex == 3
                                  ? AppStyle.urbanistBold12Black
                                  : AppStyle.urbanistMedium12Gray),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

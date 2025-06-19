import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:gift_mobile_app/controllers/OrderTrackerController.dart';
import 'package:gift_mobile_app/controllers/cart_controller.dart';
import 'package:gift_mobile_app/controllers/home_controller.dart';
import 'package:gift_mobile_app/controllers/login_controller.dart';
import 'package:gift_mobile_app/controllers/order_controller.dart';
import 'package:gift_mobile_app/controllers/profile_controller.dart';
import 'package:gift_mobile_app/controllers/search_gift_controller.dart';
import 'package:gift_mobile_app/controllers/signup_controller.dart';

class AllBindings implements Bindings {
  @override
  void dependencies() {
    debugPrint(
        '===================> Start AllBindings initialization <================');

    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SignupController>(() => SignupController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SearchGiftController>(() => SearchGiftController(),
        fenix: true);
    Get.lazyPut<OrderController>(()=>OrderController(),fenix: true);
    Get.lazyPut<CartController>(()=>CartController(),fenix: true);
    Get.put<OrderTrackerController>(OrderTrackerController(), permanent: true);
  }
}

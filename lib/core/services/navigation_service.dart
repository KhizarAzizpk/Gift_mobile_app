import 'package:get/get.dart';
import 'package:gift_mobile_app/views/add%20address%20screen/add_address_screen.dart';
import 'package:gift_mobile_app/views/address%20screen/address_screen.dart';
import 'package:gift_mobile_app/views/cart%20screen/cart_screen.dart';
import 'package:gift_mobile_app/views/edit%20kids%20ai%20profile%20screen/edit_kids_ai_profile_screen.dart';
import 'package:gift_mobile_app/views/handler_screen.dart';
import 'package:gift_mobile_app/views/help%20center%20screen/help_center_screen.dart';
import 'package:gift_mobile_app/views/generated%20gift%20screen/generated_gift_screen.dart';
import 'package:gift_mobile_app/views/login%20screen/login_screen.dart';
import 'package:gift_mobile_app/views/notification%20screen/notification_screen.dart';
import 'package:gift_mobile_app/views/order%20screen/order_screen.dart';
import 'package:gift_mobile_app/views/payment%20method%20screen/payment_method_screen.dart';
import 'package:gift_mobile_app/views/payment%20screen/payment_screen.dart';
import 'package:gift_mobile_app/views/privacy%20policy%20screen/privacy_policy_screen.dart';
import 'package:gift_mobile_app/views/profile%20screen/profile%20edit%20screen/profile_edit_screen.dart';
import 'package:gift_mobile_app/views/profile%20screen/profile_screen.dart';
import 'package:gift_mobile_app/views/search%20gift%20ai%20screen/search_gift_ai_screen.dart';
import 'package:gift_mobile_app/views/security%20screen/security_screen.dart';
import 'package:gift_mobile_app/views/signup%20screen/signup_screen.dart';

appRoutes() => [
      GetPage(
        name: '/handler-screen',
        page: () => const HandlerScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/login-screen',
        page: () => LoginScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/signup-screen',
        page: () => SignupScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/generated-gift-screen',
        page: () => GeneratedGiftScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/cart-screen',
        page: () => CartScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/order-screen',
        page: () => const OrderScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/profile-screen',
        page: () => const ProfileScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/edit-profile-screen',
        page: () =>  ProfileEditScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/edit-kids-profile-screen',
        page: () => EditKidsAiProfileScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/search-ai-screen',
        page: () => SearchGiftAiScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/add-address-screen',
        page: () => const AddAddressScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/address-screen',
        page: () => const AddressScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/notification-screen',
        page: () => const NotificationScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/payment-screen',
        page: () => const PaymentScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/payment-methods-screen',
        page: () =>  PaymentMethodsScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/security-screen',
        page: () => const SecurityScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/policy-screen',
        page: () => const PrivacyPolicyScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
      GetPage(
        name: '/help-screen',
        page: () => const HelpCenterScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    ];

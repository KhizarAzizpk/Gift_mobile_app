import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:gift_mobile_app/bindings/all_bindings.dart';
import 'package:gift_mobile_app/controllers/home_controller.dart';
import 'package:gift_mobile_app/core/services/navigation_service.dart';
import 'package:gift_mobile_app/firebase_options.dart';
import 'package:gift_mobile_app/utils/constants/app_string.dart';
import 'package:gift_mobile_app/utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = AppString.PublishableKey;
  // await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(HomeController());
  runApp(const MyApp());
}

getUserCredential() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String uid = pref.getString('userId') ?? '';
  userId.value = uid;
  debugPrint('USER LOGIN TOKEN: ${token.value}');
  debugPrint('USER LOGIN ID: ${userId.value}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        initialBinding: AllBindings(),
        debugShowCheckedModeBanner: false,
        title: AppString.projectName,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? '/login-screen'
            : '/handler-screen',
        getPages: appRoutes(),
        // home: userId.value == 0 ? LoginScreen() : HomeScreen(),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/user_model.dart';
import 'package:gift_mobile_app/utils/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = true.obs;
  var isLoading = false.obs;
  var isRememberMe = false.obs;

  var userModel = UserModel(
    uid: '',
    userName: '',
    email: '',
    phoneNumber: '',
    profileImageUrl: '',
    gender: '',
    dateOfBirth: '',
    address: '',
    createdAt: DateTime.now().toString(),
    subProfilesList: [],
    selectedCountry: '',
  ).obs;

  // TextEditing Controllers
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  Future<void> loginUser({String? email, String? password}) async {
    isLoading.value = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      await pref.setString('userId', userCredential.user!.uid);
      debugPrint('Login User  :$userCredential');
      debugPrint('Here are the credential .. ${userCredential.user!.email}');
      await getCurrentUserData();
      if(userModel.value.email.isNotEmpty){
        debugPrint("user data loaded ${userModel.value.email}");
        Get.offAllNamed('/handler-screen');
      }else{
        debugPrint("user data could not loaded ");
      }


    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('$e');
    }
  }

  Future<void> getCurrentUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(currentUser.uid)
            .get();
        debugPrint('User data fetched: ${docSnapshot.data()}');

        if (docSnapshot.exists && docSnapshot.data() != null) {
          userModel.value =
              UserModel.fromMap(docSnapshot.data() as Map<String, dynamic>);
          userModelGlobal.value = userModel.value;
        } else {
          debugPrint('No user data found for current user');
        }
      } else {
        debugPrint('No user is currently signed in');
      }
    } catch (e) {
      debugPrint('Error getting current user data: $e');
    }
  }

  Future<void> logoutuser() async {
    try {
      debugPrint("Logging out....");

      await FirebaseAuth.instance.signOut();
      debugPrint("the user has been logged out ");
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove('userId');
      debugPrint("userid removed from shrdprefc as well");
      Get.toNamed("\login-screen");
    } catch (e) {
      debugPrint("there was an error while logging out ...$e");
    }
  }
}

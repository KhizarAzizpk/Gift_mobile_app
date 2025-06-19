import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/user_model.dart';
import 'package:gift_mobile_app/utils/global_variables.dart';

class SignupController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
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
  var userNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confrirmController = TextEditingController().obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  // Register User on Firebase
  Future<void> registerUser({UserModel? userModel}) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
      userModel!.uid = userCredential.user!.uid;

      // Add user details to Firestore
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      debugPrint('Register User :$userCredential');
      Get.offAllNamed('/login-screen');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('$e');
    }
  }
}

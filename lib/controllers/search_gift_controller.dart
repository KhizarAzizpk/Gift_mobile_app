import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/models/sub_profile_model.dart';
import 'package:gift_mobile_app/models/user_model.dart';
import 'package:gift_mobile_app/utils/global_variables.dart';

class SearchGiftController extends GetxController {
  var name = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var selectedGender = ''.obs;
  var imgUrl = ''.obs;
  var isUploading = false.obs;
  var isUpdated = false.obs;
  var isSubProfileAdded = false.obs;
  var selectedInterested = ''.obs;
  var selectedNotInterested = ''.obs;
  var selectedTheme = ''.obs;
  var selectedOccasion = ''.obs;


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

  var subProfileModel = SubProfileModel(
    name: '',
    subProfileId: '',
    age: '',
    dateOfBirth: '',
    gender: '',
    address: '',
    phone: '',
    interested: '',
    notInterested: '',
    theme: '',
    occasion: '',
  ).obs;

  void fetchUserData() async {
    await getCurrentUserData();
  }

  Future<void> getCurrentUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(currentUser.uid)
            .get();

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

  // Add Sub Profile
  Future<void> addSubProfile(SubProfileModel subProfileModel) async {
    isSubProfileAdded.value = true;
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection(userCollection)
          .doc(currentUser!.uid)
          .update({
        'subProfilesList': FieldValue.arrayUnion([subProfileModel.toMap()]),
      });
      isSubProfileAdded.value = false;
      fetchUserData();
    } catch (e) {
      debugPrint('$e');
      isSubProfileAdded.value = false;
    }
  }
}

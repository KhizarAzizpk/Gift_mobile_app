import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gift_mobile_app/models/sub_profile_model.dart';
import 'package:gift_mobile_app/models/user_model.dart';
import 'package:gift_mobile_app/utils/global_variables.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var userId = ''.obs;
  var name = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var selectedGender = ''.obs;
  var imgUrl = ''.obs;
  var isUploading = false.obs;
  var isUpdated = false.obs;
  var isSubProfileAdded = false.obs;
  var selectedCountry= ''.obs;
  var isLoading = false.obs;
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
    selectedCountry:'',
  ).obs;

  // TextEditing Controllers
  var emailController = TextEditingController().obs;
  var fullNameController = TextEditingController().obs;
  var NameController = TextEditingController().obs;
  var dateofbirthController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var addressController = TextEditingController().obs;
  var postalCodeController = TextEditingController().obs;
  var cityStateController = TextEditingController().obs;
  @override
  void onInit() {

    fetchUserData();
    super.onInit();
  }


  void assignData() {
    if (userModel.value.uid.isNotEmpty && userModel.value.userName.isNotEmpty) {
      name.value = userModel.value.userName;
      email.value = userModel.value.email;
      phone.value = userModel.value.phoneNumber;
      selectedGender.value = userModel.value.gender;
      selectedCountry.value = userModel.value.selectedCountry;
      imgUrl.value = userModel.value.profileImageUrl;



      fullNameController.value.text = userModel.value.userName;
      emailController.value.text = userModel.value.email;
      phoneController.value.text = userModel.value.phoneNumber;
      dateofbirthController.value.text = userModel.value.dateOfBirth;

    }
  }

  void fetchUserData() async {
    isLoading.value = true;
    await getCurrentUserData();
    assignData();
    isLoading.value = false;
  }

  Future<void> getCurrentUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        userId.value = currentUser.uid;
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

  // Image Picker
  // getImage() async {
  //   try{
  //   print("Getimage() called");
  //   isUploading.value = true;
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //     String fileName = Path.basename(imageFile.path);
  //     print("Picked file $fileName");
  //     var upload = await FirebaseStorage.instance
  //         .ref('uploads/profile/images/$fileName')
  //         .putFile(imageFile);
  //     final url = await upload.ref.getDownloadURL();
  //     imgUrl.value = url;
  //     debugPrint("Upload complete $url");
  //     // update users database
  //     await FirebaseFirestore.instance
  //         .collection(userCollection)
  //         .doc(userId.value)
  //         .update({'profileImageUrl': url});
  //
  //     print("✅ Firestore updated successfully");
  //   }else{
  //     print("no image selected");
  //   }}catch (e){
  //     print("Exception $e");
  //
  //   }
  // }
  getImage() async {
    try {
      print("📷 getImage() called");
      isUploading.value = true;

      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        print("📂 Picked file: $fileName");

        final ref = FirebaseStorage.instance
            .ref('uploads/profile/images/$fileName.jpg');
        final uploadTask = await ref.putFile(imageFile);

        print("✅ Upload successful, getting URL...");

        final url = await ref.getDownloadURL();
        imgUrl.value = url;
        debugPrint("🌐 URL: $url");

        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(userId.value)
            .update({'profileImageUrl': url});

        print("✅ Firestore updated successfully");
      } else {
        print("⚠️ No image selected");
      }
    } catch (e, stack) {
      print("❌ Exception occurred: $e");
      print("📄 Stacktrace: $stack");
    }
  }


  // Image Picker
  getImageForFamily() async {
    isUploading.value = true;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String fileName = Path.basename(imageFile.path);
      var upload = await FirebaseStorage.instance
          .ref('uploads/profile/images/$fileName')
          .putFile(imageFile);
      final url = await upload.ref.getDownloadURL();
      imgUrl.value = url;
    }
  }

  String getAge(String birthDateString) {
    DateTime birthDate = DateTime.parse(birthDateString);
    DateTime today = DateTime.now();
    int years = today.year - birthDate.year;
    int months = today.month - birthDate.month;
    if (months < 0 || (months == 0 && today.day < birthDate.day)) {
      years--;
      months = 12 + months;
    }
    return '$years y $months m';
  }

  // Update User Profile
  Future<void> updateUser(
      {String? fullName,
      String? email,
      String? phone,
      String? dob,
      String? gender,
      String? selectedCountry,
        required String country,
      String? address,
      String? cityState,
      String? postalCode,

      }) async {
    isUpdated.value = true;
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId.value)
          .update({
        'userName': fullName,
        'email': email,
        'dateOfBirth': dob,
        'phoneNumber': phone,
        'gender': gender,
        'selectedCountry': selectedCountry,
        'address': address,
        'cityState':cityState,
        'postelCode':postalCode,
      });
      debugPrint('Update User :$userModel');
      isUpdated.value = false;
      fetchUserData();
    } catch (e) {
      isUpdated.value = false;
      debugPrint('$e');
    }
  }

  // Add Sub Profile
  Future<void> addSubProfile(SubProfileModel subProfileModel) async {
    isSubProfileAdded.value = true;
    try {
      FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId.value)
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


  //update subprofile data
  Future<void> updateSubProfile(SubProfileModel updatedProfile) async {
    try {
      final currentProfiles = List<SubProfileModel>.from(
        userModel.value.subProfilesList,
      );

      // Find index by unique identifier, for example `id`
      final index = currentProfiles.indexWhere((profile) => profile.subProfileId == updatedProfile.subProfileId);

      if (index != -1) {
        currentProfiles[index] = updatedProfile;

        // Update in Firestore
        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(userId.value)
            .update({
          'subProfilesList': currentProfiles.map((p) => p.toMap()).toList(),
        });

        // Refresh locally
        fetchUserData();
      } else {
        debugPrint("Sub-profile not found to update.");
      }
    } catch (e) {
      debugPrint("Error updating sub-profile: $e");
    }
  }
  //delete sub profile data
  Future<void> deleteSubProfile(String id) async {
    try {
      final currentProfiles = List<SubProfileModel>.from(userModel.value.subProfilesList);

      // Filter out the profile to be deleted
      final updatedProfiles = currentProfiles.where((profile) => profile.subProfileId != id).toList();

      // Update Firestore
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId.value)
          .update({
        'subProfilesList': updatedProfiles.map((p) => p.toMap()).toList(),
      });

      // Update local data
      fetchUserData();

      print("✅ Sub-profile deleted successfully.");
    } catch (e) {
      print("❌ Error deleting sub-profile: $e");
    }
  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../utils/constants/app_color.dart';
import '../../../utils/constants/app_string.dart';
import '../../../utils/style/app_style.dart';
import '../../../widgets/custom_app_bar.dart';

class ProfileEditScreen extends StatefulWidget {
   ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final controller = Get.put(ProfileController());

  late var selectedGender = 'Male';

  late var selectedCountry = 'Usa';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGender= controller.selectedGender.value;
    selectedCountry = controller.selectedCountry.value;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: AppString.editProfile,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildTextField(label: 'Full Name', controller: controller.fullNameController.value),
            _buildTextField(label: 'First Name', controller: controller.NameController.value),
            _buildTextField(
              label: 'Date of Birth',
              controller: controller.dateofbirthController.value,
              suffixIcon: Icons.calendar_today,
            ),
            _buildTextField(
              label: 'Email',
             controller:  controller.emailController.value,
              suffixIcon: Icons.email,
            ),

        _buildDropdownField(
          label: 'Country',
          value: controller.selectedCountry.value,
          options: ['USA', 'Canada', 'UK', 'Germany', 'India'],
          onChanged: (newValue) {
            setState(() {
              controller.selectedCountry.value = newValue!;
            });
          },
        ),


        _buildTextField(
              label: 'Phone Number',
             controller: controller.phoneController.value,
              prefixIcon: Icons.flag,
            ),
        _buildDropdownField(
          label: 'Gender',
          value: controller.selectedGender.value,
          options: ['Male', 'Female', 'Other'],
          onChanged: (newValue) {
            setState(() {
              controller.selectedGender.value = newValue!;
            });
          },),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.updateUser(
                  fullName: controller.fullNameController.value.text,
                  email: controller.emailController.value.text,
                  phone: controller.phoneController.value.text,
                  dob: controller.dateofbirthController.value.text,
                  gender: controller.selectedGender.value,
                  selectedCountry: controller.selectedCountry.value,
                  country: controller.selectedCountry.value,
                );
                Get.snackbar("profile Updated", 'Your profile has been updated',colorText: Colors.white,backgroundColor: Colors.greenAccent);





              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        controller: controller,
      ),
    );
  }

  // Widget _buildDropdownField({required String label, required String value}) {
   Widget _buildDropdownField({
     required String label,
     required String value,
     required List<String> options,
     required void Function(String?) onChanged,
   }) {
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: 8.0),
       child: DropdownButtonFormField<String>(
         value: value.isNotEmpty && options.contains(value) ? value : null,
         decoration: InputDecoration(
           labelText: label,
           border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
         ),
         items: options.map((option) {
           return DropdownMenuItem<String>(
             value: option,
             child: Text(option),
           );
         }).toList(),
         onChanged: onChanged,
       ),
     );
   }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/controllers/profile_controller.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

class EditKidsAiProfileScreen extends GetView<ProfileController> {
  EditKidsAiProfileScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("SubProfiles length: ${userModelGlobal.value.subProfilesList.length}");
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const CustomAppBar(
        title: AppString.editKidsAIProfile,
        elevation: 0,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: userModelGlobal.value.subProfilesList.length,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final subProfile = userModelGlobal.value.subProfilesList[index];
            return Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.all(6),
              elevation: 0,
              child: ListTile(
                leading: const CustomAssetsImage(
                  imagePath: Assets.assetsIconsMaleProfileIcon,
                  width: 50,
                  height: 50,
                  boxFit: BoxFit.contain,
                ),
                title: Text(
                  subProfile.name,
                  style: AppStyle.urbanistBold18Black,
                ),
                subtitle: Text(
                  subProfile.address.toString(),
                  style: AppStyle.urbanistMedium14Black,
                ),
                trailing: SizedBox( width:100,
                  child: Row(
                    children: [
                      IconButton(onPressed: ()async{
                        await Get.find<ProfileController>().deleteSubProfile(subProfile.subProfileId);

                      }, icon: Icon(Icons.delete,)),
                      kGap4,
                      IconButton(
                      icon: const Icon(Icons.edit, color: kBlackColor),
                      onPressed: () {
                        final TextEditingController _nameController =
                        TextEditingController(text: subProfile.name);
                        final TextEditingController _addressController =
                        TextEditingController(text: subProfile.address);

                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Edit Profile'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  TextField(
                                    controller: _addressController,
                                    decoration: const InputDecoration(
                                      labelText: 'Address',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close dialog
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    final newName = _nameController.text.trim();
                                    final newAddress = _addressController.text.trim();

                                    if (newName.isNotEmpty && newAddress.isNotEmpty) {
                                      final updatedProfile = subProfile.copyWith(
                                        name: newName,
                                        address: newAddress,
                                      );

                                      // Replace with your controller logic or setState
                                      await controller.updateSubProfile(updatedProfile);

                                      Navigator.of(context).pop(); // Close dialog
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );


                      },
                    ),

                            ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/profile_section_controller.dart';
import 'package:user/screens/editprofile/widgets/profilepick.dart';
import 'package:user/screens/widgets/submit_button.dart';

class EditProfile extends StatelessWidget {
  final String phoneNumber;

  EditProfile({super.key, required this.phoneNumber}) {
    final controller = Get.put(ProfileSectionController(), permanent: true);
    controller.init(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final ProfileSectionController controller =
        Get.find<ProfileSectionController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Profilepick(),
            const SizedBox(height: 40),

            _buildEditField(
              label: "Full Name",
              hint: "Enter your name",
              icon: Icons.person_outline,
              controller: controller.nameController,
            ),
            const SizedBox(height: 20),

            _buildEditField(
              label: "Email Address",
              hint: "example@gmail.com",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
            ),
            const SizedBox(height: 20),

            _buildEditField(
              label: "Phone Number",
              hint: "Phone Number",
              icon: Icons.phone_android_outlined,
              keyboardType: TextInputType.phone,
              controller: controller.phoneController,
              readOnly: true,
            ),
            const SizedBox(height: 40),

            // ✅ Save Button (CORRECT)
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SubmitButton(
                      label: "Save Changes",
                      onTap: controller.updateProfile,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor:
                readOnly ? Colors.grey.shade200 : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }
}

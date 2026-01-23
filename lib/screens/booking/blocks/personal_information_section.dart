import 'package:flutter/material.dart';
import 'package:user/screens/booking/widgets/build_textfeild.dart';
import 'package:user/screens/booking/widgets/section_title.dart';

class PersonalInformationSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const PersonalInformationSection({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle('Personal Information'),
        const SizedBox(height: 16),

        // Full Name
        buildTextField(
          controller: nameController,
          label: 'Full Name',
          icon: Icons.person_outline,
          validator: (value) =>
              value!.isEmpty ? 'Please enter your name' : null,
        ),
        const SizedBox(height: 16),

        // Email
        buildTextField(
          controller: emailController,
          label: 'Email Address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Phone
        buildTextField(
          controller: phoneController,
          label: 'Phone Number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) =>
              value!.isEmpty ? 'Please enter your phone number' : null,
        ),
      ],
    );
  }
}

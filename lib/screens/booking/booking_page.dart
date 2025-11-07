import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/booking/widgets/build_booking_summary.dart';
import 'package:user/screens/booking/widgets/build_bottom_bar.dart';
import 'package:user/screens/booking/widgets/build_date_selector.dart';
import 'package:user/screens/booking/widgets/build_duration.dart';
import 'package:user/screens/booking/widgets/build_property_summary.dart';
import 'package:user/screens/booking/widgets/build_textfeild.dart';
import 'package:user/screens/booking/widgets/bulild_termandconditon.dart';
import 'package:user/screens/booking/widgets/section_title.dart';
import 'package:user/screens/utils/app_color.dart';


class BookingPage extends StatelessWidget {
  final Property property;
  final BookingController controller=Get.put(BookingController());
  

  BookingPage({super.key, required this.property});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Property',
          style: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildPropertySummary(property),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle('Personal Information'),
                    const SizedBox(height: 16),
                    buildTextField(
                      controller: controller.nameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),
                    buildTextField(
                      controller: controller.emailController,
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
                    buildTextField(
                      controller: controller.phoneController,
                      label: 'Phone Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your phone number' : null,
                    ),
                    const SizedBox(height: 32),
                    sectionTitle('Rental Details'),
                    const SizedBox(height: 16),
                    buildDateSelector(context),
                    const SizedBox(height: 16),
                    buildDurationSelector(),
                    const SizedBox(height: 32),
                    sectionTitle('Additional Message'),
                    const SizedBox(height: 16),
                    buildTextField(
                      controller: controller.messageController,
                      label: 'Message (Optional)',
                      icon: Icons.message_outlined,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    buildTermsCheckbox(),
                    const SizedBox(height: 32),
                    buildBookingSummary(property),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(context),
    );
  }

 
  

 
  


}

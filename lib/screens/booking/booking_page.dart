import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/booking/blocks/additional_message_section.dart';
import 'package:user/screens/booking/blocks/personal_information_section.dart';
import 'package:user/screens/booking/blocks/rental_details_section.dart';
import 'package:user/screens/booking/widgets/build_booking_summary.dart';
import 'package:user/screens/booking/widgets/build_bottom_bar.dart';
import 'package:user/screens/booking/widgets/build_date_selector.dart';
import 'package:user/screens/booking/widgets/build_duration_selector.dart';
import 'package:user/screens/booking/widgets/build_property_summary.dart';
import 'package:user/screens/booking/widgets/bulild_termandconditon.dart';
import 'package:user/screens/utils/app_color.dart';

class BookingPage extends StatelessWidget {
  final Property property;
  final BookingController controller = Get.put(BookingController());

  // ✅ computed based on property.collectiontype
  final bool isSellProperty;

  BookingPage({super.key, required this.property})
    : isSellProperty = property.collectiontype == "sell_property";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.black),
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
            // Property Summary
            buildPropertySummary(property),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Personal information
                    PersonalInformationSection(
                      nameController: controller.nameController,
                      emailController: controller.emailController,
                      phoneController: controller.phoneController,
                    ),

                    const SizedBox(height: 16),

                    // 👉 Rental details ONLY for non-sell properties
                    if (!isSellProperty) ...[
                      RentalDetailsSection(
                        dateSelectorBuilder:
                            (context) => buildDateSelector(context),
                        durationSelector: buildDurationSelector(),
                        isSellProperty: false,
                      ),
                      const SizedBox(height: 32),
                    ],

                    // 👉 Advance payment ONLY for sell_property
                    if (isSellProperty) ...[
                      const Text(
                        "Advance Payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: controller.advanceAmountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.currency_rupee),
                          hintText: "Enter advance amount",
                        ),
                        onChanged: (value) {
                          controller.advanceAmount.value =
                              value.trim(); // ✅ SYNC
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter advance amount';
                          }
                          final amt = int.tryParse(value.trim()) ?? 0;
                          if (amt <= 0) {
                            return 'Advance amount must be greater than 0';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 32),
                    ],

                    // Additional message
                    AdditionalMessageSection(
                      messageController: controller.messageController,
                    ),

                    const SizedBox(height: 24),

                    // Terms & conditions
                    buildTermsCheckbox(),

                    const SizedBox(height: 32),

                    // Booking Summary
                    buildBookingSummary(property, isSellProperty),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // 👉 Pass property to bottom bar as before (we'll derive isSellProperty inside)
      bottomNavigationBar: buildBottomBar(context, property),
    );
  }
}

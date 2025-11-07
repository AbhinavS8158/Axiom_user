 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildBottomBar(BuildContext context) {
  final BookingController controller = Get.put(BookingController());
    return Obx(() => Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: ElevatedButton(
            onPressed: controller.agreeToTerms.value
                ? () => _submitBooking(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Confirm Booking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }


   void _submitBooking(BuildContext context) {
    final BookingController controller =Get.put(BookingController());
    if (controller.formKey.currentState!.validate()) {
      if (controller.moveInDate.value == null) {
        Get.snackbar(
          'Required',
          'Please select a move-in date',
          backgroundColor: Colors.orange.shade100,
          colorText: Colors.orange.shade900,
        );
        return;
      }

      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 20),
              const Text('Booking Confirmed!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text(
                'Your booking request has been submitted successfully.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // close dialog
                  Get.back(); // go back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue,
                ),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      );
    }
  }
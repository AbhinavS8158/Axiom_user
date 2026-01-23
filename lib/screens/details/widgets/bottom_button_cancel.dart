import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

Widget bottomButtonCancel(
  BuildContext context,
  Property property, {
  required String bookingId,
}) {
  final BookingController bookingController =
      Get.find<BookingController>();

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColor.white,
      boxShadow: [
        BoxShadow(
          color: AppColor.grey.withValues(alpha: 0.3),
          blurRadius: 10,
          offset: const Offset(0, -3),
        ),
      ],
    ),
    child: SafeArea(
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                bookingController.cancelBooking(
                  context: context,
                  bookingId: bookingId,
                  property: property,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColor.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Cancel Booking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

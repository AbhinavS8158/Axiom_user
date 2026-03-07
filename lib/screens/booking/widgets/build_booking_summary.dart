import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';
Widget buildBookingSummary(Property property, bool isSellProperty) {
  final BookingController controller = Get.find<BookingController>();

  if (isSellProperty) {
    return Obx(() {
      final advance = controller.advanceAmount.value;

      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.blue.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _summaryRow('Total Amount', property.price),

            _summaryRow(
              'Advance payment',
              advance.isEmpty ? 'Not entered' : advance,
            ),
          ],
        ),
      );
    });
  }

  return Obx(
    () => Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _summaryRow('Monthly Rent', property.price),
          _summaryRow('Duration', controller.selectedDuration.value),
        _summaryRow(
  'Move-in Date',
  controller.moveInDate.value == null
      ? 'Not selected'
      : DateFormat('dd MMM yyyy')
          .format(controller.moveInDate.value!),
),

        ],
      ),
    ),
  );
}

Widget _summaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColor.grey)),
        Row(
          children: [
            if (label.toLowerCase().contains('amount') ||
                label.toLowerCase().contains('rent') ||
                label.toLowerCase().contains('advance'))
              const Icon(Icons.currency_rupee, size: 16),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    ),
  );
}

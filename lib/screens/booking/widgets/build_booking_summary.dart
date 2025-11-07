

  import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildBookingSummary(property) {
  final BookingController controller = Get. put(BookingController());
    return Obx(() => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor.blue.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Booking Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _summaryRow('Monthly Rent', property.price),
              _summaryRow('Duration', controller.selectedDuration.value),
              _summaryRow(
                'Move-in Date',
                controller.moveInDate.value == null
                    ? 'Not selected'
                    : '${controller.moveInDate.value!.day}/${controller.moveInDate.value!.month}/${controller.moveInDate.value!.year}',
              ),
            ],
          ),
        ));
  }
  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColor.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

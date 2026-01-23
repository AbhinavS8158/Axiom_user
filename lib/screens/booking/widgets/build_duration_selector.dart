import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildDurationSelector() {
  final BookingController controller = Get.put(BookingController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 🔹 Title
      const Text(
        'Rental Duration',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),
      ),
      const SizedBox(height: 12),

      // 🔹 Duration Chips
      Obx(
        () => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.durations.map((duration) {
            final selected =
                controller.selectedDuration.value == duration;

            return InkWell(
              onTap: () =>
                  controller.selectedDuration.value = duration,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColor.blue
                      : AppColor.grey1,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  duration,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? AppColor.white
                        : AppColor.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

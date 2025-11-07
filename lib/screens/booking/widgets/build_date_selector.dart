 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildDateSelector(BuildContext context) {
  final BookingController controller = Get.put(BookingController());
    return Obx(() {
      final date = controller.moveInDate.value;
      return InkWell(
        onTap: () async {
          final selected = await showDatePicker(
            context: context,
            initialDate: DateTime.now().add(const Duration(days: 7)),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (selected != null) controller.moveInDate.value = selected;
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today_outlined, color: AppColor.blue),
              const SizedBox(width: 16),
              Text(
                date == null
                    ? 'Select move-in date'
                    : '${date.day}/${date.month}/${date.year}',
                style: TextStyle(
                  fontSize: 16,
                  color: date == null ? AppColor.grey : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
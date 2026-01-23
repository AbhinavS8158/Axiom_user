import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildTermsCheckbox() {
  final BookingController controller = Get.put(BookingController());
    return Obx(() => Row(
          children: [
            Checkbox(
              value: controller.agreeToTerms.value,
              onChanged: (val) => controller.agreeToTerms.value = val ?? false,
              activeColor: AppColor.blue,
            ),
            const Text('I agree to the Terms & Conditions'),
          ],
        ));
  }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/payment/payment.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildBottomBar(BuildContext context, Property property) {
  final BookingController controller = Get.put(BookingController());

  return Obx(() => Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () async {
            bool ok = await controller.continueBooking(property);

            if (ok) {
              Get.to(() => Payment(property: property));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                controller.agreeToTerms.value ? AppColor.blue : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ));
}

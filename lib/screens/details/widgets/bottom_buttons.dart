 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/booking/booking_page.dart';
import 'package:user/screens/utils/app_color.dart';

Widget bottomButtons(Property property) {
 
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed:  () {
                  Get.to(() => BookingPage(property: property));  
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColor.blue,
                  disabledBackgroundColor: AppColor.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                   'Book Now',
                  style: const TextStyle(
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
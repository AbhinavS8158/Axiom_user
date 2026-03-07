import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/controller/services/stripe_service.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildBottomBar(BuildContext context, Property property) {
  final BookingController controller = Get.find<BookingController>();

  return Obx(
    () => Container(
      padding: const EdgeInsets.all(20),
      color: AppColor.white,
      child: ElevatedButton(
        onPressed: () async {
          final ok = await controller.continueBooking(property);
          if (!ok) return;

          final bool isSellProperty =
              property.collectiontype == "sell_property";

          int amount;
          if (isSellProperty) {
            final txt = controller.advanceAmountController.text.trim();
            amount = int.tryParse(txt) ?? 0;
          } else {
            amount = int.tryParse(property.price) ?? 0;
          }

          if (amount <= 0) {
            Get.snackbar(
              "Invalid Amount",
              isSellProperty
                  ? "Advance amount is not valid."
                  : "Property price is not valid.",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            return;
          }

          try {
            await StripeService.instance.makePayment(amount: amount);

            await controller.confirmBookingAndMarkPropertyBooked(
              property,
              paidAmount: amount,
            );

          } catch (e) {
            Get.snackbar(
              "Payment Failed",
              "Your payment could not be completed. Please try again.",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              controller.agreeToTerms.value ? AppColor.blue : AppColor.grey,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

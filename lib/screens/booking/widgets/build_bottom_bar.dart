import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/booking_controller.dart';
import 'package:user/controller/services/stripe_service.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildBottomBar(BuildContext context, Property property) {
  // ✅ Get the existing controller (created in BookingPage)
  final BookingController controller = Get.find<BookingController>();

  return Obx(
    () => Container(
      padding: const EdgeInsets.all(20),
      color: AppColor.white,
      child: ElevatedButton(
        onPressed: () async {
          // 1️⃣ Validate form/date/terms depending on property type
          final ok = await controller.continueBooking(property);
          if (!ok) return;

          final bool isSellProperty =
              property.collectiontype == "sell_property";

          // 2️⃣ Choose amount:
          //    - sell_property → advance entered by user
          //    - others        → full property price
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
            // 3️⃣ Stripe payment
            await StripeService.instance.makePayment(amount: amount);

            // 4️⃣ On success → save booking + mark property booked
            await controller.confirmBookingAndMarkPropertyBooked(
              property,
              paidAmount: amount,
            );

          } catch (e) {
            // 5️⃣ Any error → treat as payment failure
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

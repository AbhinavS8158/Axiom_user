import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/otp_controller.dart';
import 'package:user/screens/utils/app_color.dart';
import 'package:user/screens/widgets/otp_input_feild.dart';
import 'package:user/screens/widgets/submit_button.dart';
import 'package:user/screens/widgets/title_text.dart';

class OtpScreen extends StatelessWidget {
  final String otp;
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber, required this.otp});

  @override
  Widget build(BuildContext context) {
    // Correct way: Initialize the controller once
    final OtpController controller = Get.put(OtpController(otp));

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          // Added scroll view to prevent overflow
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const TitleText(label: "Verify Account"),
              const SizedBox(height: 20),
              Text(
                "Please enter the verification code sent to\n$phoneNumber",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 40),
              Center(
                child: OtpInputField(controller: controller.pinController),
              ),
              const SizedBox(height: 40),

              // Wrap button in Obx to show loading state
              // Inside OtpScreen build method
              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: AppColor.primary,
                            ), // Use your primary color
                          ),
                        )
                        : SubmitButton(
                          label: "Verify",
                          onTap: () {
                           
                            FocusScope.of(context).unfocus();
                            controller.verifyOtp();
                          },
                        ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => controller.resendOtp(phoneNumber),
                  child: const Text(
                    "Resend code",
                    style: TextStyle(color: AppColor.resend),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

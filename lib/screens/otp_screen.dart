import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/utils/app_color.dart';

import '../controller/otp_controller.dart';
import 'widgets/otp_input_feild.dart';
import 'widgets/submit_button.dart';
import 'widgets/title_text.dart';

class OtpScreen extends StatelessWidget {
  final String otp;
  final String phoneNumber;

  const OtpScreen({
    required this.phoneNumber,
    required this.otp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final controller = Get.put(OtpController(otp));

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.15,
                child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    child: OtpInputField(controller: pinController), 
                  ),
                  const SizedBox(height: 40),
                  SubmitButton(
                    label: "Verify",
                    onTap: () {
                      controller.verifyOtp(pinController.text.trim(), context);
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        controller.resendOtp(phoneNumber, context);
                        log("resend button pressed");
                      },
                      child: const Text(
                        "Resend code",
                        style: TextStyle(
                          color: AppColor.resend,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

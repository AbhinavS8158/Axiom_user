import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:user/screens/utils/app_color.dart';


class CustomPinput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;

  const CustomPinput({
    super.key,
    required this.controller,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColor.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColor.resend, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      textStyle: const TextStyle(color: AppColor.white),
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColor.resend,
        border: Border.all(color:AppColor.resend),
      ),
    );

    return Pinput(
      controller: controller,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      onCompleted: onCompleted,
    );
  }
}

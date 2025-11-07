import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  var moveInDate = Rxn<DateTime>();
  var selectedDuration = '6 Months'.obs;
  var agreeToTerms = false.obs;

  final durations = [
    '3 Months',
    '6 Months',
    '1 Year',
    '2 Years',
    'Long Term',
  ];

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

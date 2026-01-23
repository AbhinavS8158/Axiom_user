import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StripePaymentController extends GetxController {
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final upiIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var selectedPaymentMethod = ''.obs;
  var saveCard = false.obs;

  var cardNumber = ''.obs;
  var cardHolder = ''.obs;
  var expiry = ''.obs;

  @override
  void onInit() {
    super.onInit();

    cardNumberController.addListener(() {
      cardNumber.value = cardNumberController.text;
    });
    cardHolderController.addListener(() {
      cardHolder.value = cardHolderController.text;
    });
    expiryController.addListener(() {
      expiry.value = expiryController.text;
    });
  }

  void selectMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void toggleSaveCard() => saveCard.value = !saveCard.value;

  String formatCardNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    final buf = StringBuffer();
    for (int i = 0; i < digitsOnly.length && i < 16; i++) {
      if (i > 0 && i % 4 == 0) buf.write(' ');
      buf.write(digitsOnly[i]);
    }
    return buf.toString();
  }

  String formatExpiry(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 2) return digits;

    final mm = digits.substring(0, min(2, digits.length));
    final yy = digits.length > 2 ? digits.substring(2, min(4, digits.length)) : '';

    return yy.isEmpty ? mm : "$mm/$yy";
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    upiIdController.dispose();
    super.onClose();
  }
}

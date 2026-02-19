import 'dart:convert';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:http/http.dart' as http;
import 'package:user/constant.dart';
import 'package:user/screens/payment/payment_failed.dart';
import 'package:user/screens/payment/payment_success.dart'; // stripeSecretKey here

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment({required int amount, String currency = 'inr'}) async {
    try {
      final paymentIntentClientSecret = await _createPaymentIntent(
        amount,
        currency,
      );

      if (paymentIntentClientSecret == null) {
        print('PaymentIntent creation failed');
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Abhinav',
        ),
      );

      await _processPayment();

      print('PaymentIntent client_secret: $paymentIntentClientSecret');
    } catch (e) {
      print('Error in makePayment: $e');
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currencyCode) async {
    try {
      final url = Uri.parse('https://api.stripe.com/v1/payment_intents');

      final fixedCurrency = currencyCode.toLowerCase().trim();

      final Map<String, String> body = {
        'amount': _calculateAmount(amount), // ₹ -> paise
        'currency': fixedCurrency,
        'payment_method_types[]': 'card',
      };

      print('Request body to Stripe: $body');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print('Stripe status: ${response.statusCode}');
      print('Stripe response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        return decoded['client_secret'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error in _createPaymentIntent: $e');
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.off(() => const PaymentSuccessPage(),
        transition: Transition.fadeIn, duration: const Duration(milliseconds: 500));

    } on StripeException catch (e) {
      print('StripeException: $e');
       Get.off(() => const PaymentFailedPage(),
        transition: Transition.downToUp, duration: const Duration(milliseconds: 500));
    } catch (e) {
      print('Error in _processPayment: $e');
      
    Get.off(() => const PaymentFailedPage(),
        transition: Transition.downToUp, duration: const Duration(milliseconds: 500));
    }
  }

  String _calculateAmount(int amount) {
    // amount = rupees → Stripe needs paise
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  
}

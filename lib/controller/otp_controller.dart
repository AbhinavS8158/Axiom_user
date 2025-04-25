import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/Home/home_screen.dart';

class OtpController extends GetxController {
  final String initialOtp;
  OtpController(this.initialOtp) {
    verificationId.value = initialOtp;
  }

  final TextEditingController pinController = TextEditingController();
  var verificationId = ''.obs;

  Future<void> verifyOtp(String otp, BuildContext context) async {
    if (otp.isEmpty) {
      Get.snackbar("Empty", "Enter Your OTP",snackPosition: SnackPosition.BOTTOM);
      
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
  
      Get.snackbar("Success", "Login successfully",snackPosition: SnackPosition.BOTTOM
      ,backgroundColor:Colors.green.shade100,);
      
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (err) {
      Get.snackbar("error", err.message ?? err.code);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(err.message ?? err.code)),
      // );{}
    }
  }

  Future<void> resendOtp(String phoneNumber, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar("Mismatch", "verification failed ${e.message}");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Verification failed: ${e.message}')),
        // );
      },
      codeSent: (String newVerificationId, int? resendToken) {
        verificationId.value = newVerificationId;
        Get.snackbar("Successful", "OTP code send successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:Colors.green.shade100
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("OTP code resent successfully")),
        // );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}

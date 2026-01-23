import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/bottomnav/bottom_nav.dart';

class OtpController extends GetxController {
  final String initialVerificationId;
  OtpController(this.initialVerificationId);

  final TextEditingController pinController = TextEditingController();
  final verificationId = ''.obs;
  final isLoading = false.obs;
  
  // Instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    verificationId.value = initialVerificationId;
  }

  Future<void> verifyOtp() async {
    final otp = pinController.text.trim();

    if (otp.isEmpty || otp.length < 6) {
      Get.snackbar("Invalid Input", "Please enter the full 6-digit code",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange.shade200);
      return;
    }

    try {
      isLoading.value = true;

      // 1. Authenticate with Firebase
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // 2. Check if user document already exists in Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          // 3. Create new user document only if it doesn't exist
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'phoneNumber': user.phoneNumber,
            'createdAt': FieldValue.serverTimestamp(),
            'role': 'user', // You can add default fields here
          });
          print("New user record created");
        } else {
          print("User already exists, skipping creation");
        }

        // 4. Show Success Snackbar
        Get.snackbar(
          "Success",
          "Logged in successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade400,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          duration: const Duration(seconds: 2),
        );

        // 5. Navigate to Home
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(() =>  BottomNav());
        });
      }
    } on FirebaseAuthException catch (err) {
      String message = "Verification failed.";
      if (err.code == 'invalid-verification-code') {
        message = "The code you entered is incorrect.";
      }
      Get.snackbar("Error", message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> resendOtp(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        Get.snackbar(
          "Verification Failed",
          e.message ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
        );
      },
      codeSent: (newVerificationId, _) {
        verificationId.value = newVerificationId;
        Get.snackbar(
          "OTP Sent",
          "OTP code sent successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
        );
      },
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }
}

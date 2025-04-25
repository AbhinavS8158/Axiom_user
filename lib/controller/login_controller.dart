import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user/screens/onboarding_screen.dart';

import '../screens/otp_screen.dart';

class LoginController extends GetxController {
  final GoogleSignIn _googleSignIn=GoogleSignIn();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  final numberController = TextEditingController();
  var isLoading = false.obs;

  void sendOtp(BuildContext context) async {
    String number = numberController.text.trim();

    if (number.isEmpty || number.length != 10 || !RegExp(r'^[0-9]{10}$').hasMatch(number)) {
      Get.snackbar(
        "Invalid Phone Number",
        "Please enter a valid 10-digit phone number without spaces.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
      return;
    }

    isLoading.value = true; 

    String phoneNumber = '+91$number';

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
        isLoading.value = false; 
      },
      codeSent: (String otp, int? token) {
        Get.snackbar(
          "OTP Sent",
          "OTP has been sent to $phoneNumber",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
        );
        isLoading.value = false; 

        Get.to(() => OtpScreen(
              otp: otp,
              phoneNumber: phoneNumber,
            ));
      },
      codeAutoRetrievalTimeout: (String otp) {
        isLoading.value = false;
      },
    );
  }
 Future<void> logout() async {
  // Show confirmation dialog
  Get.defaultDialog(
    title: 'Logout Confirmation',
    middleText: 'Are you sure you want to logout?',
    textConfirm: 'Yes',
    textCancel: 'No',
    confirmTextColor: Colors.white,
    onConfirm: () async {
      try {
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => OnboardingScreen());
      } catch (e) {
        Get.snackbar(
          'Logout Failed',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    },
    onCancel: () {
      Get.back();
    }
  );
}
  Future signinwithgoole()async{
    try{
      final googleUser =await _googleSignIn.signIn();
        if (googleUser == null) return null; 

         final googleAuth = await googleUser.authentication;
         Get.snackbar("Success", "Google sign in successfully");

              final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth.accessToken,
                    idToken: googleAuth.idToken,
            );
             final userCredential = await _auth.signInWithCredential(credential);

               return userCredential.user;  
                  
    }catch(e){
      Get.snackbar("google sign in failed", "google sign in failed $e");
      // log("$e");
      return null;
    }
  }
  Future<void> signOut() async {
        
 
        await _googleSignIn.signOut();
        
  
        await _auth.signOut(); 
    }
}

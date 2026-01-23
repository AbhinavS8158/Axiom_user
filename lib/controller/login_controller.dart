import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user/screens/onboarding_screen.dart';

import '../screens/otp_screen.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // If needed, you can add scopes or clientId here
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
    // clientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com', // only if required
  );

  final numberController = TextEditingController();

  var isLoading = false.obs;        // for phone OTP button
  var isGoogleLoading = false.obs;  // for Google button

  // ------------------- PHONE OTP LOGIN -------------------

  void sendOtp(BuildContext context) async {
    String number = numberController.text.trim();

    if (number.isEmpty ||
        number.length != 10 ||
        !RegExp(r'^[0-9]{10}$').hasMatch(number)) {
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

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),

      verificationCompleted: (PhoneAuthCredential credential) async {
        // Optional: auto sign-in
        // await _auth.signInWithCredential(credential);
        // Get.offAll(() => BottomNav());
      },

      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Verification failed: ${e.message}"),
          ),
        );
      },

      codeSent: (String verificationId, int? resendToken) {
        isLoading.value = false;

        Get.snackbar(
          "OTP Sent",
          "OTP has been sent to $phoneNumber",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
        );

        Get.to(
          () => OtpScreen(
            otp: verificationId,
            phoneNumber: phoneNumber,
          ),
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        isLoading.value = false;
      },
    );
  }

  // ------------------- GOOGLE SIGN-IN -------------------

  Future<User?> signInWithGoogle() async {
  try {
    isGoogleLoading.value = true;
    debugPrint('DEBUG: Starting Google sign-in');

    final GoogleSignInAccount? googleUser =
        await _googleSignIn.signIn();

    if (googleUser == null) {
      debugPrint('DEBUG: User cancelled Google sign-in');
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    final User? user = userCredential.user;

    if (user == null) {
      throw Exception('Firebase user is null after Google sign-in');
    }

    /// ---------------- SAVE USER TO FIRESTORE ----------------
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final userDoc = await userRef.get();

    if (!userDoc.exists) {
      await userRef.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'phone': user.phoneNumber ?? '',
        'provider': 'google',
        'createdAt': FieldValue.serverTimestamp(),
        'role':'user'
      });
    }
    /// -------------------------------------------------------

    Get.snackbar(
      "Success",
      "Google sign-in successful",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
    );

    debugPrint('DEBUG: User saved & login successful');
    return user;
  } on FirebaseAuthException catch (e, stack) {
    debugPrint(
      'DEBUG: FirebaseAuthException: ${e.code} ${e.message}\n$stack',
    );

    Get.snackbar(
      "Google Sign-In Failed",
      e.message ?? 'Authentication error',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
    return null;
  } catch (e, stack) {
    debugPrint('DEBUG: Google sign-in error: $e\n$stack');

    Get.snackbar(
      "Google Sign-In Failed",
      'Something went wrong. Try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
    return null;
  } finally {
    isGoogleLoading.value = false;
    debugPrint('DEBUG: signInWithGoogle finished');
  }
}


  // ------------------- LOGOUT -------------------

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Logout Confirmation',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          await _auth.signOut();
          await _googleSignIn.signOut();

          Get.offAll(() => OnboardingScreen());
        } catch (e) {
          Get.snackbar(
            'Logout Failed',
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
      onCancel: () => Get.back(),
    );
  }

  @override
  void onClose() {
    numberController.dispose();
    super.onClose();
  }
}

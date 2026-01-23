import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/bottomnav/bottom_nav.dart';
import 'package:user/screens/utils/app_color.dart';

import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> navigateBasedOnAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Get.offAll(() => BottomNav());
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Run navigation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateBasedOnAuth();
    });

    return Scaffold(
      backgroundColor: AppColor.bg,
      body: Center(
        child: Text(
          'AXIOM',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColor.axiom,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

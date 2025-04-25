import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/utils/appcolor.dart';

import 'Home/home_screen.dart';
import 'onboarding_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateBasedOnAuth();

    
  }
    Future<void> navigateBasedOnAuth() async {
    await Future.delayed(const Duration(seconds: 2)); 
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      
      Get.offAll(() =>  HomeScreen());
    } else {
      
      Get.offAll(() =>  OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColor.bg,
      body: Center(
        child: Text(
          'AXIOM',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColor.Axiom,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

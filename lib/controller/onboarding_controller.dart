// controllers/onboarding_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/login_screen.dart';

import '../model/onboard.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  var currentIndex = 0.obs;

  final List<OnboardingContent> contentList = [
    OnboardingContent(
      imagePath: 'assets/images/real-estate-agent.png',
      title: "Discover the Properties",
      description:
          "Looking for your dream home or a\nvaluable investment? Explore our wide\nrange of premium properties designed\nto suit your needs.",
    ),
    OnboardingContent(
      imagePath: 'assets/images/rentsearch.png',
      title: "Rent with Ease",
      description:
          "Find your perfect home hassle-free\nwith verified listings and affordable\nprices.",
    ),
    OnboardingContent(
      imagePath: 'assets/images/complex.png',
      title: "Find the PG",
      description:
          "🏠 Find the Perfect PG! Comfortable,\naffordable, and fully furnished\naccommodations in prime locations.\nBook your stay now! ✨",
    ),
    OnboardingContent(
      imagePath: 'assets/images/pg.png',
      title: "Rent the Commercial",
      description:
          "🏠 Find the Perfect Commercial Comfortable,\naffordable, and fully furnished accommodations\nin prime locations. Book your stay now! ✨",
    ),
  ];

  void nextPage() {
    if (currentIndex.value < contentList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    } else {
      Get.off(() => LoginScreen());
    }
  }

  void skip() {
    Get.off(() => LoginScreen());
  }
}

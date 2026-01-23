import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {

  final pageController = PageController(initialPage: 0);
  final notchController = NotchBottomBarController(index: 0);
  final RxInt selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
    notchController.index=index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

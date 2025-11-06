import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/onboarding_controller.dart';
import 'package:user/screens/utils/app_color.dart';

class ProgressLine extends StatelessWidget {
   ProgressLine({super.key});
final OnboardingController controller =Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(()=>LinearProgressIndicator(
                value: (controller.currentIndex.value+1)/  controller.contentList.length,
                backgroundColor: Colors.grey[300],
                color: AppColor.primary,
                minHeight: 2,
              )),
            );
  }
}
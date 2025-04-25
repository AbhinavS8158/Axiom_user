
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/utils/appcolor.dart';

import '../controller/onboarding_controller.dart';
import 'widgets/custom_next_button.dart';
import 'widgets/title_text.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: controller.skip,
                  child: const Text("Skip"),
                ),
              ],
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.contentList.length,
                onPageChanged: (index) {
                  controller.currentIndex.value = index;
                },
                itemBuilder: (_, index) {
                  final content = controller.contentList[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(content.imagePath),
                      const SizedBox(height: 50),
                      TitleText(label: content.title),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          content.description,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => CustomNextButton(
                  label: controller.currentIndex.value == controller.contentList.length - 1
                      ? "Get Started"
                      : "Next",
                  onTap: controller.nextPage,
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user/controller/login_controller.dart';
import 'package:user/screens/bottomnav/bottom_nav.dart';
import 'package:user/screens/utils/app_color.dart';

import 'widgets/country_code_dropdown.dart';
import 'widgets/submit_button.dart';
import 'widgets/title_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final availableHeight = media.size.height - media.padding.top - media.padding.bottom;

    return Scaffold(
      backgroundColor: AppColor.bg,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
              ),
            ),

            SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: media.viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: availableHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 66),
                      const TitleText(label: "Login to Proceed"),
                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Icon(Icons.check_circle, color: AppColor.checkcircle),
                          const SizedBox(width: 8),
                          const Text(
                            'Easy connect with seller',
                            style: TextStyle(fontSize: 16, color: AppColor.text),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: AppColor.checkcircle),
                          SizedBox(width: 8),
                          Text(
                            'Personalized experience',
                            style: TextStyle(fontSize: 16, color: AppColor.text),
                          ),
                        ],
                      ),

                      const SizedBox(height: 36),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColor.grey1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CountryCodeDropdown(),
                            const VerticalDivider(width: 12),
                            Expanded(
                              child: TextField(
                                controller: controller.numberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Obx(() {
                        return SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: controller.isLoading.value
                              ? Center(
                                  child: Lottie.network(
                                    'https://lottie.host/ca497732-421d-4a10-8bf5-1118a11baa2b/gt9Thho9OU.json',
                                    height: 48,
                                  ),
                                )
                              : SubmitButton(
                                  label: "Send OTP",
                                  onTap: () => controller.sendOtp(context),
                                ),
                        );
                      }),

                      SizedBox(height: 100,),

                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Quick Login Option",
                              style: TextStyle(color: AppColor.text),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: controller.isGoogleLoading.value
                                  ? null
                                  : () async {
                                      final user = await controller.signInWithGoogle();
                                      if (user != null) {
                                        Get.offAll(() => BottomNav());
                                      }
                                    },
                              child: controller.isGoogleLoading.value
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/google.png',
                                      height: 30,
                                      width: 30,
                                    ),
                            ),
                            const SizedBox(width: 24),
                            Image.asset(
                              'assets/images/facebook.png',
                              height: 30,
                              width: 30,
                            ),
                          ],
                        );
                      }),

                      const SizedBox(height: 16), 
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

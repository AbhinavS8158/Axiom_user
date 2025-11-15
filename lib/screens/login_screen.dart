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
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),
                  const TitleText(label: "Login to Proceed"),
                  const SizedBox(height: 50),

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

                  const SizedBox(height: 50),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColor.grey2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CountryCodeDropdown(),
                        const VerticalDivider(),
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
                      child:
                          controller.isLoading.value
                              ? Lottie.network(
                                'https://lottie.host/ca497732-421d-4a10-8bf5-1118a11baa2b/gt9Thho9OU.json',
                              )
                              : SubmitButton(
                                label: "Send OTP",
                                onTap: () => controller.sendOtp(context),
                              ),
                    );
                  }),

                  const SizedBox(height: 70),


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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final user = await controller.signinwithgoole();
                          if (user != null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>  BottomNav(),
                              ),
                              (route) => false, 
                            );
                          }
                        },
                        child: Image.asset(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

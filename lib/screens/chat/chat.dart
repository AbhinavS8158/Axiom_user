import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: Center(
        child: Text("chat screen"),
      ),
    );
  }
}
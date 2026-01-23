import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildEmptySection(String title, String message, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    decoration: BoxDecoration(
      color: AppColor.grey50,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: AppColor.grey2.withOpacity(0.8),
      ),
      boxShadow: [
        BoxShadow(
          color: AppColor.black.withOpacity(0.04),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon container for emphasis
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: AppColor.grey1,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 36,
            color: AppColor.grey,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: AppColor.grey6,
          ),
        ),
      ],
    ),
  );
}

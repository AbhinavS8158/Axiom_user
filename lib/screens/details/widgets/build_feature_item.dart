import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildFeatureItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 28, color: AppColor.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColor.grey6),
        ),
      ],
    );
  }
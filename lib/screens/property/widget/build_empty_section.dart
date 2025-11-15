
  import 'package:flutter/widgets.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildEmptySection(String title, String message, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColor.grey50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.grey2),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: AppColor.grey3,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color:AppColor.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColor.grey6,
            ),
          ),
        ],
      ),
    );
  }
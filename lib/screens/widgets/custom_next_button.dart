import 'package:flutter/material.dart';
import 'package:user/screens/utils/appcolor.dart';

class CustomNextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CustomNextButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor = AppColor.CustomNextButton_bg,
    this.textColor =  AppColor.CustomNextButton_text,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
           boxShadow: [
            BoxShadow(
              color: AppColor.CustomNextButton_shadow,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

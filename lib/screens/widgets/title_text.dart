import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String label;
  const TitleText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}

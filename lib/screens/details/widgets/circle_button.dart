import 'package:flutter/material.dart';

Widget circleButton({
  required IconData icon,
  required VoidCallback onPressed,
  Color? iconColor, // 👈 optional color for the icon
  Color backgroundColor = Colors.white, // 👈 optional background color
  double size = 24, // 👈 customizable icon size
}) {
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: backgroundColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: IconButton(
      icon: Icon(icon, color: iconColor ?? Colors.black, size: size),
      onPressed: onPressed,
      splashRadius: 24,
    ),
  );
}

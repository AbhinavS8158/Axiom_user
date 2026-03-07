 import 'package:flutter/widgets.dart';

Widget detailselectionTile(String title, IconData icon) => Row(
  children: [
    Icon(icon, size: 24),
    const SizedBox(width: 8), 
    Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
);
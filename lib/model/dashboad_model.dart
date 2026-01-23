
import 'package:flutter/material.dart';

class DashboadModel {
  final String title;
  final IconData icon;
  final Color color;
  final Color borderColor;
   final VoidCallback onTap;

  DashboadModel({
  required this.title, 
  required this.icon, 
  required this.color, 
  required this.borderColor,
  required this.onTap});
}

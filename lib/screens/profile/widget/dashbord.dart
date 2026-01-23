import 'package:flutter/material.dart';
import 'package:user/model/dashboad_model.dart';

class Dashbord extends StatelessWidget {
  final DashboadModel model;
  const Dashbord({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model.onTap,
      child: Container(
        decoration: BoxDecoration(
          color:model. color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color:model. borderColor, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(model.icon, size: 40),
            SizedBox(height: 12),
            Text(
              model.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      )
    );
  }
}


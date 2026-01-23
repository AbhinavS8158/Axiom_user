import 'package:flutter/material.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';

class FoodAvailability extends StatelessWidget {
  final String food;

  const FoodAvailability({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return buildWhiteCard(
      title: 'Food availbility',
      child: Text(
        food,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.6,
        ),
      ),
    );
  }
}

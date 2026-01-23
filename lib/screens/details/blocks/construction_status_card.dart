import 'package:flutter/material.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';

class ConstructionStatusCard extends StatelessWidget {
  final String status;

  const ConstructionStatusCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return buildWhiteCard(
      title: 'Construction Status',
      child: Text(
        status,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.6,
        ),
      ),
    );
  }
}

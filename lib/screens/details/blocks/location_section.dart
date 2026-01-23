import 'package:flutter/material.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';

class LocationSection extends StatelessWidget {
  final String location;
  final Widget locationCard;

  const LocationSection({
    super.key,
    required this.location,
    required this.locationCard,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildWhiteCard(
          title: "Location",
          child: locationCard,
        ),
        const SizedBox(height: 8),
      
      ],
    );
  }
}

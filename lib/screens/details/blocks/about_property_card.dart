import 'package:flutter/material.dart';
import 'package:user/screens/details/widgets/build_white_card.dart';

class AboutPropertyCard extends StatelessWidget {
  final String about;

  const AboutPropertyCard({
    super.key,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return buildWhiteCard(
      title: 'About the property',
      child: Text(
        about,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[700],
          height: 1.6,
        ),
      ),
    );
  }

}

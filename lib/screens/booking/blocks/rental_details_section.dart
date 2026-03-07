import 'package:flutter/material.dart';
import 'package:user/screens/booking/widgets/section_title.dart';

class RentalDetailsSection extends StatelessWidget {
  final Widget Function(BuildContext) dateSelectorBuilder;
  final Widget durationSelector;
  final bool isSellProperty;

  const RentalDetailsSection({
    super.key,
    required this.dateSelectorBuilder,
    required this.durationSelector,
    required this.isSellProperty,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       isSellProperty?const SizedBox.shrink(): sectionTitle('Rental Details'),
       isSellProperty?const SizedBox(height: 1,): const SizedBox(height: 16),

       isSellProperty? const SizedBox.shrink(): dateSelectorBuilder(context),
       isSellProperty?const SizedBox(height: 1,): const SizedBox(height: 16),

        isSellProperty ? const SizedBox.shrink() : durationSelector,
      ],
    );
  }
}

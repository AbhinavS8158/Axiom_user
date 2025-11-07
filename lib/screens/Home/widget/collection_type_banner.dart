import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

class CollectionTypeBanner extends StatelessWidget {
  final String collectionType;

  const CollectionTypeBanner({
    super.key,
    required this.collectionType,
  });

  @override
  Widget build(BuildContext context) {
    if (collectionType.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    // Extract the part before the underscore
    final displayText = collectionType.split('_').first;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.blueAccent,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          'For ${displayText}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: AppColor.blueAccent,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

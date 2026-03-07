import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

class PropertyHeaderCard extends StatelessWidget {
  final dynamic property;

  const PropertyHeaderCard({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _statusChip(
                'Ready to move',
                Icons.check_circle_outline,
              ),
              const SizedBox(width: 12),
              _statusChip(
                property.furnished,
                Icons.weekend_outlined,
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            property.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            children: [
              Icon(
                Icons.currency_rupee,
                size: 18,
                color: AppColor.blue,
              ),
              Text(
                property.price,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blue,
                ),
              ),
              Text(
                '/Month',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.grey,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            property.location,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _statusChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColor.blue),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: AppColor.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

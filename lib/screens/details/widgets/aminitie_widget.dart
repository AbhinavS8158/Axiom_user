import 'package:flutter/material.dart';
import 'package:user/model/property_card_model.dart';

class AmenitiesWidget extends StatelessWidget {
  final Property property;

  const AmenitiesWidget({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amenities = property.amenities;

    if (amenities.isEmpty) {
      return Text(
        'No amenities available',
        style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
      );
    }

    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: amenities.map((amenity) {
        // ✅ Handle both Map and String formats
        String amenityName = '';
        if (amenity is Map<String, dynamic>) {
          amenityName = amenity['name']?.toString() ?? '';
        } else if (amenity is String) {
          amenityName = amenity.toString();
        }

        return Chip(
          backgroundColor: Colors.blue[50],
          label: Text(
            amenityName,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          avatar: const Icon(Icons.check_circle, color: Colors.blue, size: 16),
        );
      }).toList(),
    );
  }
}

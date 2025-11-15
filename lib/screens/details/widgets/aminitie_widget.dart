import 'package:flutter/material.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/utils/app_color.dart';

class AmenitiesWidget extends StatelessWidget {
  final Property property;

  const AmenitiesWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final amenities = property.amenities;

    if (amenities.isEmpty) {
      return Text(
        'No amenities available',
        style: TextStyle(color: AppColor.grey6, fontStyle: FontStyle.italic),
      );
    }

    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: amenities.map((amenity) {
        // ✅ Handle both Map and String formats
        String amenityName = '';
        amenityName = amenity['name']?.toString() ?? '';
      
        return Chip(
          backgroundColor: AppColor.blue,
          label: Text(
            amenityName,
            style:  TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColor.blue,
            ),
          ),
          avatar:  Icon(Icons.check_circle, color: AppColor.blue, size: 16),
        );
      }).toList(),
    );
  }
}

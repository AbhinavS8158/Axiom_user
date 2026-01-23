import 'package:flutter/material.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/widgets/aminitie_icons.dart';
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

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.0,
      children: amenities.map((a) {
        String name = a['name'] ?? '';
        IconData icon = AmenityIcons.getIcon(name,);

        return _amenityCard(icon, name);
      }).toList(),
    );
  }

  Widget _amenityCard(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: AppColor.blue),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          
          ),
        ],
      ),
    );
  }
}

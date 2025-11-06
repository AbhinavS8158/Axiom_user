import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';

class SearchItems extends StatelessWidget {
  SearchItems({super.key});

  final AllPropertyController controller = Get.find<AllPropertyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final visibleProperties = controller.filteredList.where((p) {
        // Hide unavailable ones
        final status = p.status.toString().trim().toLowerCase();
        return !(status == '2' || status == 'unavailable');
      }).toList();

      if (visibleProperties.isEmpty) {
        return const Center(
          child: Text(
            'No properties found.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: visibleProperties.length,
        separatorBuilder: (_, __) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final property = visibleProperties[index];
          return PropertyCard(property: property);
        },
      );
    });
  }
}

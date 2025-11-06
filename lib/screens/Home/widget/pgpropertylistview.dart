import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/pg_property_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';

class Pgpropertylistview extends StatelessWidget {
   Pgpropertylistview({super.key});
final PgPropertyController controller  = Get.put(PgPropertyController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        final visibleProperties = controller.propertyList.where((p) {
          // Hide properties where status == 2 or 'unavailable'
          final status = p.status.toString().trim().toLowerCase();
          return (status == '1');
        }).toList(); 

        if (visibleProperties.isEmpty) {
          return const Center(
            child: Text('No available properties.'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: visibleProperties.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final property = visibleProperties[index];
            return PropertyCard(property: property);
          },
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:user/controller/sell_property_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';

class Sellpropertylistview extends StatelessWidget {
   Sellpropertylistview({super.key});
final SellPropertyController controller =Get.put(SellPropertyController());
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/controller/booking_list_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/screens/property/widget/build_booking_card.dart';
import 'package:user/screens/property/widget/build_empty_section.dart';
import 'package:user/screens/property/widget/build_section_header.dart';
import 'package:user/screens/utils/app_color.dart';

class PropertyList extends StatelessWidget {
  PropertyList({super.key});

  final BookingListController controller =
      Get.put(BookingListController());

      final AllPropertyController allPropertyController = 
      Get.put(AllPropertyController());

      
      final FavoritesController favoritesController = 
      Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const Text(
          'My Bookings',
          style: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
      Obx(() {
  if (controller.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }

  if (controller.bookedProperties.isEmpty) {
    return buildEmptySection(
      'No bookings yet',
      'Your booked properties will appear here',
      Icons.bookmark_border,
    );
  }

  return ListView(
    padding: const EdgeInsets.symmetric(vertical: 16),
    children: [
      buildSectionHeader(
        icon: Icons.bookmark,
        title: 'My Bookings',
        count: controller.bookedProperties.length,
        color: AppColor.checkcircle,
      ),
      const SizedBox(height: 12),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.bookedProperties.length,
        itemBuilder: (context, index) {
          final property = controller.bookedProperties[index];
final booking =
    controller.getBookingByPropertyId(property.id);

return buildBookingCard(property, booking);





        },
      ),
    ],
  );
})
    );
  }
}

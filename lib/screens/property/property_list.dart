import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';
import 'package:user/screens/property/widget/build_booking_card.dart';
import 'package:user/screens/property/widget/build_empty_section.dart';
import 'package:user/screens/property/widget/build_section_header.dart';
import 'package:user/screens/utils/app_color.dart';

class PropertyList extends StatelessWidget {
  PropertyList({super.key});
  final AllPropertyController allcontroller = Get.put(AllPropertyController());
  final FavoritesController favcontroller = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const Text(
          'My Properties',
          style: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          // Get favorite properties
          final favprops = allcontroller.propertyList
              .where((p) => favcontroller.isFavorite(p.id))
              .toList();

          // Get booked properties (adjust this condition based on your model)
          final bookedProps = allcontroller.propertyList
              // .where((p) => p.isBooked == true)
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Favorites Section
              buildSectionHeader(
                icon: Icons.favorite,
                title: 'Favorites',
                count: favprops.length,
                color: AppColor.fav,
              ),
              favprops.isEmpty
                  ? buildEmptySection(
                      'No favorites yet',
                      'Properties you favorite will appear here',
                      Icons.favorite_border,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: favprops.length,
                      itemBuilder: (context, index) {
                        final property = favprops[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: PropertyCard(property: property),
                        );
                      },
                    ),

              const SizedBox(height: 24),

              // Bookings Section
              buildSectionHeader(
                icon: Icons.bookmark,
                title: 'My Bookings',
                count: bookedProps.length,
                color: AppColor.checkcircle,
              ),
              bookedProps.isEmpty
                  ? buildEmptySection(
                      'No bookings yet',
                      'Your booked properties will appear here',
                      Icons.bookmark_border,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: bookedProps.length,
                      itemBuilder: (context, index) {
                        final property = bookedProps[index];
                        return buildBookingCard(property);
                      },
                    ),

              const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }

 

  
}
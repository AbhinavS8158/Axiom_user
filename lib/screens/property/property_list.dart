import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Properties',
          style: TextStyle(
            color: Colors.black87,
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
              _buildSectionHeader(
                icon: Icons.favorite,
                title: 'Favorites',
                count: favprops.length,
                color: Colors.red,
              ),
              favprops.isEmpty
                  ? _buildEmptySection(
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
              _buildSectionHeader(
                icon: Icons.bookmark,
                title: 'My Bookings',
                count: bookedProps.length,
                color: Colors.green,
              ),
              bookedProps.isEmpty
                  ? _buildEmptySection(
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
                        return _buildBookingCard(property);
                      },
                    ),

              const SizedBox(height: 24),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(property) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Property Card
          PropertyCard(property: property),

          // Booking Status Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Booking Confirmed',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // View booking details
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColor.primary ?? Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('View Details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySection(String title, String message, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
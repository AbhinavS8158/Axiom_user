import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/widgets/aminitie_widget.dart';
import 'package:user/screens/details/widgets/bottom_buttons.dart';
import 'package:user/screens/details/widgets/build_feature_item.dart';
import 'package:user/screens/details/widgets/circle_button.dart';
import 'package:user/screens/details/widgets/imagae_carousel.dart';
import 'package:user/screens/utils/app_color.dart';

class Details extends StatelessWidget {
  final Property property;
  final FavoritesController favController = Get.put(FavoritesController());

  Details({super.key, required this.property});

  bool get isUnavailable =>
      property.status.toString().trim().toLowerCase() == '2' ||
      property.status.toString().trim().toLowerCase() == 'unavailable';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🏞 App Bar with Image Carousel
          SliverAppBar(
  expandedHeight: 300,
  pinned: true,
  backgroundColor: AppColor.bg,
  elevation: 0,
  leading: circleButton(
    icon: Icons.arrow_back,
    iconColor: AppColor.black,
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    Obx(() {
      final isFav = favController.isFavorite(property.id);
      return circleButton(
        icon: isFav ? Icons.favorite : Icons.favorite_border,
        iconColor: isFav ? AppColor.fav : Colors.black, // ❤️ icon changes color only
        onPressed: () => favController.toggleFavorite(property),
      );
    }),
  ],
  flexibleSpace: FlexibleSpaceBar(
    background: Stack(
      children: [
        // 🖼 Image Carousel
        ImageCarousel(imageUrls: property.imageUrl),

        // 🏷 Availability Badge
        Positioned(
          top: 60,
          right: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isUnavailable
                  ? AppColor.fav
                  : AppColor.checkcircle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isUnavailable ? 'UNAVAILABLE' : 'AVAILABLE',
              style: const TextStyle(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
        
),
        

          // 📋 Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏡 Property Title
                  Text(
                    property.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 💰 Price
                  Row(
                    children: [
                      Text(
                        property.price,
                        style:  TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blue,
                        ),
                      ),
                      Text(
                        '/Month',
                        style: TextStyle(fontSize: 16, color:AppColor.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 🛏 Property Features
                  if (property.bedrooms.isNotEmpty && property.bedrooms != '0')
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColor.grey1,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildFeatureItem(
                            Icons.king_bed_outlined,
                            property.bedrooms,
                            'Bedrooms',
                          ),
                          _divider(),
                          buildFeatureItem(
                            Icons.category_outlined,
                            property.propertyType,
                            'Type',
                          ),
                          _divider(),
                          buildFeatureItem(
                            Icons.bathtub_outlined,
                            property.bathrooms,
                            'Bathrooms',
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),

                  // 📝 Description
                  _sectionTitle('Description'),
                  Text(
                    property.about,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.grey2,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ⚡ Power Backup
                  _sectionTitle('Power Backup'),
                  Text(
                    property.powerbackup,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.grey2,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ✨ Amenities
                  _sectionTitle('Amenities'),
                  const SizedBox(height: 12),
                  AmenitiesWidget(property: property),
                  const SizedBox(height: 24),

                  // 📍 Location
                  _sectionTitle('Location'),
                  const SizedBox(height: 12),
                  _buildLocationCard(),

                  const SizedBox(height: 24),

                  // 👤 Owner Section
                  _sectionTitle('Contact Owner'),
                  const SizedBox(height: 12),
                  _buildOwnerSection(),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🛒 Bottom Buttons
      bottomNavigationBar: bottomButtons(property),
    );
  }

  // 🔹 Divider
  Widget _divider() => Container(height: 40, width: 1, color: Colors.grey[300]);

  // 🔹 Section Title Widget
  Widget _sectionTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );

  // 🔹 Location Map Placeholder
  Widget _buildLocationCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColor.grey3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 48, color: AppColor.grey3),
            const SizedBox(height: 8),
            Text(
              'Map View',
              style: TextStyle(color: AppColor.grey3),
            ),
            Text(
              property.location,
              style: TextStyle(color: AppColor.grey3),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Owner Info Section
  Widget _buildOwnerSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.grey1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.blue1,
            child: Icon(Icons.person, size: 30, color: AppColor.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  'Real Estate Agent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Contact for property details',
                  style: TextStyle(
                    color: AppColor.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon:  Icon(Icons.phone, color: AppColor.blue),
            onPressed: () {},
          ),
          IconButton(
            icon:  Icon(Icons.message, color: AppColor.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

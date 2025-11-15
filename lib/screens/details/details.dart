import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/widgets/aminitie_widget.dart';
import 'package:user/screens/details/widgets/bottom_buttons.dart';
import 'package:user/screens/details/widgets/build_feature_item.dart';
import 'package:user/screens/details/widgets/buildowner_widget.dart';
import 'package:user/screens/details/widgets/circle_button.dart';
import 'package:user/screens/details/widgets/imagae_carousel.dart';
import 'package:user/screens/details/widgets/location_widget.dart';
import 'package:user/screens/details/widgets/selection_title.dart';
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: AppColor.bg,
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
                    iconColor: isFav ? AppColor.fav : AppColor.black,
                    onPressed: () => favController.toggleFavorite(property),
                  );
                }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    ImageCarousel(imageUrls: property.imageUrl),
                    Positioned(
                      top: 60,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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

            // MAIN CONTENT
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(property.title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(property.price,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColor.blue)),
                        Text('/Month',
                            style: TextStyle(
                                fontSize: 16, color: AppColor.grey)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // FEATURES
                    if (property.bedrooms.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColor.grey1,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildFeatureItem(Icons.king_bed_outlined,
                                property.bedrooms, 'Bedrooms'),
                            _divider(),
                            buildFeatureItem(Icons.category_outlined,
                                property.propertyType, 'Type'),
                            _divider(),
                            buildFeatureItem(Icons.bathtub_outlined,
                                property.bathrooms, 'Bathrooms'),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    detailselectionTile('Description', Icons.notes),
                    Text(property.about,
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColor.grey2,
                            height: 1.5)),
                    const SizedBox(height: 24),

                    if (property.collectiontype == 'sell_property') ...[
                      detailselectionTile(
                          "Construction Status", Icons.sync),
                      const SizedBox(height: 8),
                      Text(property.constructionstatus,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColor.grey2,
                              height: 1.5)),
                    ],

                    if (property.collectiontype == 'pg_property') ...[
                      detailselectionTile(
                          "Food Availability", Icons.restaurant),
                      const SizedBox(height: 8),
                      Text(property.food,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColor.grey2,
                              height: 1.5)),
                    ],

                    const SizedBox(height: 24),

                    detailselectionTile('Power Backup', Icons.electric_bolt),
                    Text(property.powerbackup,
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColor.grey2,
                            height: 1.5)),
                    const SizedBox(height: 24),

                    detailselectionTile('Amenities', Icons.category),
                    const SizedBox(height: 12),
                    AmenitiesWidget(property: property),
                    const SizedBox(height: 24),

                    detailselectionTile('Location', Icons.location_on),
                    const SizedBox(height: 12),
                    buildLocationCard(property),
                    const SizedBox(height: 5),
                    Text(property.location,
                        style: TextStyle(
                            color: AppColor.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),

                    // OWNER INFO
                    detailselectionTile( 'Contact Owner', Icons.person),
                    const SizedBox(height: 12),

                    buildOwnerSection(property.userId),

                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomButtons(property),
    );
  }

  Widget _divider() =>
      Container(height: 40, width: 1, color: AppColor.grey3);

}
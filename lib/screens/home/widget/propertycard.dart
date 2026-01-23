import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/details.dart';
import 'package:user/screens/home/widget/collection_type_banner.dart';
import 'package:user/screens/utils/app_color.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final bool showFavoriteIcon;

  PropertyCard({
    super.key,
    required this.property,
    this.showFavoriteIcon = false,
  });

  final FavoritesController favController =
      Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    final bool isUnavailable =
        property.status.toString().trim().toLowerCase() == '2' ||
        property.bookingstatus.toString().trim().toLowerCase() == 'booked';

    final bool isSellProperty =
        property.collectiontype.toString().trim().toLowerCase() ==
            'sell_property';

    return InkWell(
      onTap: () => Get.to(() => Details(property: property)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withValues(alpha: 0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// 🏞 Property Image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: property.imageUrl.isNotEmpty
                  ? Image.network(
                      property.imageUrl.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: AppColor.grey3,
                          child: Center(
                            child: Image.asset(
                              "assets/images/placeholder.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: AppColor.grey3,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColor.grey,
                            size: 40,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: AppColor.grey3,
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: AppColor.grey,
                      ),
                    ),
            ),

            /// ❤️ Favorite Icon (ONLY from favorites screen)
            if (showFavoriteIcon)
              Positioned(
                top: 15,
                right: 15,
                child: Obx(() {
                  final isFav =
                      favController.isFavorite(property.id.toString());
                  return GestureDetector(
                    onTap: () => favController.toggleFavorite(property),
                    child: CircleAvatar(
                      backgroundColor: AppColor.white,
                      radius: 18,
                      child: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            isFav ? AppColor.fav : AppColor.grey,
                        size: 20,
                      ),
                    ),
                  );
                }),
              ),

            /// 🏷 Availability Badge
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color:
                      isUnavailable ? AppColor.fav : AppColor.checkcircle,
                  borderRadius: BorderRadius.circular(5),
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

            /// 📄 Property Details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          property.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        CollectionTypeBanner(
                          collectionType: property.collectiontype,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (property.bedrooms.isNotEmpty &&
                            property.bedrooms != '0') ...[
                          Icon(
                            Icons.king_bed_outlined,
                            size: 16,
                            color: AppColor.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${property.bedrooms} Beds',
                            style: TextStyle(
                              color: AppColor.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                        const Spacer(),
                        Text(
                          '₹${property.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        isSellProperty
                            ? const Text('/- only')
                            : Text(
                                '/Month',
                                style: TextStyle(
                                  color: AppColor.grey,
                                  fontSize: 14,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

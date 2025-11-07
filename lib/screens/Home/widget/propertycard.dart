import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/details.dart';
import 'package:user/screens/home/widget/collection_type_banner.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    // Handle numeric or string status values safely
    final bool isUnavailable =
        property.status.toString().trim().toLowerCase() == '2' ||
        property.status.toString().trim().toLowerCase() == 'unavailable';

    // ✅ Check if this is a "sell" property
    final bool isSellProperty =
        property.collectiontype.toString().trim().toLowerCase() == 'sell_property';

    return InkWell(
      onTap: () => Get.to(() => Details(property: property)),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 🏞 Property image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: property.imageUrl.isNotEmpty
                  ? Image.network(
                      property.imageUrl.first,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.grey, size: 40),
                      ),
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child:
                          const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
            ),

            // 🏷 Availability badge
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isUnavailable ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  isUnavailable ? 'UNAVAILABLE' : 'AVAILABLE',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // 📄 Property details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                        CollectionTypeBanner(collectionType: property.collectiontype)

                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        if (property.bedrooms.isNotEmpty &&
                            property.bedrooms != '0') ...[
                          const Icon(
                            Icons.king_bed_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${property.bedrooms} Beds',
                            style: const TextStyle(
                              color: Colors.grey,
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
                      isSellProperty?Text("/- only"):
                          const Text(
                            '/Month',
                            style: TextStyle(
                              color: Colors.grey,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/details/widgets/circle_button.dart';
import 'package:user/screens/details/widgets/image_carousel.dart';
import 'package:user/screens/utils/app_color.dart';

class PropertySliverAppBar extends StatelessWidget {
  final Property property;
  final FavoritesController favController;

  const PropertySliverAppBar({
    super.key,
    required this.property,
    required this.favController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 550,
      pinned: true,
      backgroundColor: AppColor.bg,

      leading: circleButton(
        icon: Icons.arrow_back,
        iconColor: AppColor.black,
        onPressed: () => Navigator.pop(context),
      ),

      actions: [
        Obx(() {
          final isFav = favController.isFavorite(property.id.toString());
          return circleButton(
            icon: isFav ? Icons.favorite : Icons.favorite_border,
            iconColor: isFav ? AppColor.fav : AppColor.black,
            onPressed: () => favController.toggleFavorite(property),
          );
        }),
      ],

      flexibleSpace: FlexibleSpaceBar(
        background: ImageCarousel(
          imageUrls: property.imageUrl
        ),
      ),
    );
  }
}

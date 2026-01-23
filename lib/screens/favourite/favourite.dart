import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';
import 'package:user/screens/utils/app_color.dart';

class Favourite extends StatelessWidget {
  Favourite({super.key});

  final AllPropertyController allController = Get.find<AllPropertyController>();
  final FavoritesController favController = Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        title: const Text(
          "My Wishlist ❤️",
          style: TextStyle(
            color: AppColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.white,
        iconTheme: const IconThemeData(color: AppColor.black),
      ),
      body: Obx(() {
        final favoriteProps = allController.propertyList
            .where((p) => favController.isFavorite(p.id))
            .toList();

        // ✅ EMPTY STATE WITH LOTTIE
        if (favoriteProps.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/Empty Heart.json',
                  height: 220,
                  repeat: true,
                ),
                const SizedBox(height: 16),
                Text(
                  "No favorites yet!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Tap the heart icon to save properties",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.grey.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: favoriteProps.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final property = favoriteProps[index];
            return PropertyCard(
              property: property,
              showFavoriteIcon: true,
            );
          },
        );
      }),
    );
  }
}

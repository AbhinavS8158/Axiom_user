import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/controller/favourite_controller.dart';
import 'package:user/screens/home/widget/propertycard.dart';
import 'package:user/screens/utils/app_color.dart';

class Favourite extends StatelessWidget {
  Favourite({super.key});

  final AllPropertyController allController = Get.find<AllPropertyController>();
  final FavoritesController favController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(

        title: const Text("My Wishlist ❤️"),
        backgroundColor: AppColor.bg,
        foregroundColor: AppColor.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        final favoriteProps = allController.propertyList
            .where((p) => favController.isFavorite(p.id))
            .toList();

        if (favoriteProps.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border,
                    size: 80, color: AppColor.grey.withOpacity(0.5)),
                const SizedBox(height: 12),
                 Text(
                  "No favorites yet!",
                  style: TextStyle(fontSize: 18, color: AppColor.grey),
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
            return PropertyCard(property: property);
          },
        );
      }),
    );
  }
}

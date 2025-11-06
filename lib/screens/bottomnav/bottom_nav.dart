import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart' show AnimatedNotchBottomBar, BottomBarItem;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/bottom_nav_controller.dart';
import 'package:user/screens/favourite/favourite.dart';
import 'package:user/screens/home/home_screen.dart';
import 'package:user/screens/profile/profile.dart';
import 'package:user/screens/property/property_list.dart';
// import 'package:user/screens/favourite/favourite.dart'; // ✅ Uncomment later when ready

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  /// ✅ Main pages for tabs
  final List<Widget> _pages = [
    const HomeScreen(),
    PropertyList(),
    Favourite(),
     Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      /// ✅ Controlled PageView (prevents swipe navigation)
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),

      /// ✅ Reactive Animated Notch Bottom Bar
      bottomNavigationBar: Obx(() {
        final selectedIndex = controller.selectedIndex.value;

        return AnimatedNotchBottomBar(
          notchBottomBarController: controller.notchController,
          color: Colors.white,
          notchColor: Colors.blueAccent,
          showLabel: true,
          itemLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          kIconSize: 24.0,
          kBottomRadius: 22.0,
          elevation: 8.0,
          durationInMilliSeconds: 250,

          /// ✅ Bottom Bar Items
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: const Icon(Icons.home_outlined, color: Colors.grey),
              activeItem: const Icon(Icons.home, color: Colors.white),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.business_outlined, color: Colors.grey),
              activeItem: const Icon(Icons.business, color: Colors.white),
              itemLabel: 'Property',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.favorite_border, color: Colors.grey),
              activeItem: const Icon(Icons.favorite, color: Colors.white),
              itemLabel: 'Wishlist',
            ),
            BottomBarItem(
              inActiveItem: const Icon(Icons.person_outline, color: Colors.grey),
              activeItem: const Icon(Icons.person, color: Colors.white),
              itemLabel: 'Profile',
            ),
          ],

          /// ✅ Update page index when tapped
          onTap: (index) => controller.changePage(index),
        );
      }),
    );
  }
}

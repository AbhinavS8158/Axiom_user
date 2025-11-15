import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/bottom_nav_controller.dart';
import 'package:user/screens/favourite/favourite.dart';
import 'package:user/screens/home/home_screen.dart';
import 'package:user/screens/profile/profile.dart';
import 'package:user/screens/property/property_list.dart';
import 'package:user/screens/utils/app_color.dart';

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

      /// ✅ PageView controlled by GetX
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),

      /// ✅ Bottom bar - observe only index changes
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: controller.notchController,
        color: AppColor.white,
        notchColor: AppColor.blueAccent,
        showLabel: true,
        itemLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        kIconSize: 24.0,
        kBottomRadius: 22.0,
        elevation: 8.0,
        durationInMilliSeconds: 250,

        /// ✅ Bottom bar items (static)
        bottomBarItems:  [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_outlined, color: AppColor.grey),
            activeItem: Icon(Icons.home, color: AppColor.white),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.business_outlined, color: AppColor.grey),
            activeItem: Icon(Icons.business, color: AppColor.white),
            itemLabel: 'Property',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.favorite_border, color: AppColor.grey),
            activeItem: Icon(Icons.favorite, color: AppColor.white),
            itemLabel: 'Wishlist',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.person_outline, color: AppColor.grey),
            activeItem: Icon(Icons.person, color: AppColor.white),
            itemLabel: 'Profile',
          ),
        ],

        /// ✅ Reactively update index when tapped
        onTap: (index) => controller.changePage(index),
      ),
    );
  }
}

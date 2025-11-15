import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/tabview_controller.dart';
import 'package:user/screens/home/widget/logo.dart';
import 'package:user/screens/home/widget/pgpropertylistview.dart';
import 'package:user/screens/home/widget/rentpropertylistview.dart';
import 'package:user/screens/home/widget/searchbar.dart';
import 'package:user/screens/home/widget/sellpropertylistview.dart';
import 'package:user/screens/home/widget/tabview.dart';
import 'package:user/screens/utils/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure controller is available
    final TabControllerX tabController = Get.put(TabControllerX());

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            const Logo(),
             Searchbar(),
            const TabView(),
            Expanded(
              child: Obx(() {
                switch (tabController.selectedIndex.value) {
                  case 0:
                    return Rentpropertylistview(); // RENT
                  case 1:
                    return Sellpropertylistview(); // BUY
                  case 2:
                    return Pgpropertylistview(); // PG
                  default:
                    return const Center(
                      child: Text('Unknown Tab'),
                    );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
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
   HomeScreen({super.key});
final TabControllerX tabController = Get.put(TabControllerX());
  @override
  Widget build(BuildContext context) {
   final String currentUserId = FirebaseAuth.instance.currentUser?.uid ??'';
    

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            Logo(currentUserId:currentUserId ,),
             Searchbar(),
            const TabView(),
            Expanded(
              child: Obx(() {
                switch (tabController.selectedIndex.value) {
                  case 0:
                    return Rentpropertylistview(); 
                  case 1:
                    return Sellpropertylistview();
                  case 2:
                    return Pgpropertylistview(); 
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

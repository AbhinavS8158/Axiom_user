import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/tabview_controller.dart';
import 'package:user/screens/utils/app_color.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    final TabControllerX tabController = Get.put(TabControllerX());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Obx(() {
        return CustomSlidingSegmentedControl<int>(
          fixedWidth: 100,
          initialValue: tabController.selectedIndex.value,
          children: const {
            0: Text(
              'RENT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            1: Text(
              'BUY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            2: Text(
              'PG',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          },
          decoration: BoxDecoration(
            color: AppColor.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColor.grey3!),
          ),
          thumbDecoration: BoxDecoration(
            color: AppColor.grey2,
            borderRadius: BorderRadius.circular(30),
          ),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          onValueChanged: (value) {
            tabController.changeTab(value);
          },
        );
      }),
    );
  }
}

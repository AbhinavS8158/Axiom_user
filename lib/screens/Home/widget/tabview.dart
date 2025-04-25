import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/tabview_controller.dart';

class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
  
    final TabControllerX tabController = Get.put(TabControllerX());

    return 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
               
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        tabController.changeTab(0); 
                      },
                      child: Obx(() {
                       
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: tabController.selectedIndex.value == 0
                                ? Colors.grey[200]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'RECENTS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: tabController.selectedIndex.value == 0
                                  ? Colors.black
                                  : Colors.grey[600],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                 
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        tabController.changeTab(1); 
                      },
                      child: Obx(() {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: tabController.selectedIndex.value == 1
                                ? Colors.grey[200]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'ALL',
                            style: TextStyle(
                              fontSize: 14,
                              color: tabController.selectedIndex.value == 1
                                  ? Colors.black
                                  : Colors.grey[600],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
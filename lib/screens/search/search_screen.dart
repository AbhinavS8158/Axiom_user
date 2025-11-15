import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/screens/search/filter_bottom_sheet.dart';
import 'package:user/screens/search/search_items.dart';
import 'package:user/screens/utils/app_color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AllPropertyController controller = Get.put(AllPropertyController());

    return Scaffold(
      backgroundColor: AppColor.grey50,
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search Bar Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.grey1,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor.grey3!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient:  LinearGradient(
                          colors: [AppColor.bluegredient, AppColor.bluegredient1],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.search, color: AppColor.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        onChanged: (value) => controller.searchQuery.value = value,
                        style: const TextStyle(fontSize: 16),
                        decoration:  InputDecoration(
                          hintText: 'Search cities...',
                          hintStyle: TextStyle(color: AppColor.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    // Filter Button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _showFilterBottomSheet(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Icon(Icons.tune, color: AppColor.grey6, size: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),

            // 🏠 Property List
            Expanded(child: SearchItems()),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }
}

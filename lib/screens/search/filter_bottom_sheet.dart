import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/filter_controller.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return Obx(() {
      final filter = controller.filter.value;

      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            // Handle Bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Filters Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     _buildFilterSection(
                      'Type of Service ',
                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        
                        
                        children: [ 'For rent','For sell', 'For Pg',]
                            .map((service) => _buildSelectableChip(
                                  service,
                                  filter.services == service,
                                  () => controller.updateTypeofService(
                                    filter.services == service ? '' : service,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 24,),
                    _buildFilterSection(
                      'Property Type',
                      Wrap(
                        spacing: 5,
                        runSpacing: 10,
                        
                        
                        children: [ 'Apartment','Independent House', 'Villa', 'Penthouse', 'Duplex']
                            .map((type) => _buildSelectableChip(
                                  type,
                                  filter.propertyType == type,
                                  () => controller.updatePropertyType(
                                    filter.propertyType == type ? '' : type,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildFilterSection(
                      'Price Range',
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          '< ₹50k',
                          '₹50k - ₹1L',
                          '₹1L - ₹2L',
                          '₹2L - ₹5L',
                          '> ₹5L'
                        ].map((range) => _buildSelectableChip(
                              range,
                              filter.priceRange == range,
                              () => controller.updatePriceRange(
                                filter.priceRange == range ? '' : range,
                              ),
                            ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildFilterSection(
                      'Bedrooms',
                      Wrap(
                        spacing: 10,
                        children: ['1', '2', '3', '4', '5']
                            .map((bed) => _buildSelectableChip(
                                  bed,
                                  filter.bedrooms == bed,
                                  () => controller.updateBedrooms(
                                    filter.bedrooms == bed ? '' : bed,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controller.clearAll,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: const Text('Clear All'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.applyFilters();
                        Navigator.pop(context);
                        print('✅ Applied Filters: ${filter.toString()}');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildSelectableChip(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

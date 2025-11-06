import 'package:get/get.dart';
import 'package:user/controller/all_property_controller.dart';
import 'package:user/model/filter_model.dart';

class FilterController extends GetxController {
  final filter = FilterModel().obs;

  void updatePropertyType(String type) =>
      filter.update((f) => f!.propertyType = type);
  void updatePriceRange(String range) =>
      filter.update((f) => f!.priceRange = range);
  void updateBedrooms(String bed) =>
      filter.update((f) => f!.bedrooms = bed);

  void clearAll() {
    filter.update((f) => f!.clear());
    _applyFilters(); // Reset filter results
  }

  void applyFilters() {
    _applyFilters();
  }

  void _applyFilters() {
    final allPropertyController = Get.find<AllPropertyController>();
    allPropertyController.applyFilter(filter.value);
  }
}

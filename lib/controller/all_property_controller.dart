import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/filter_model.dart';
import 'package:user/model/property_card_model.dart';

class AllPropertyController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var propertyList = <Property>[].obs;     // All properties from Firestore
  var filteredList = <Property>[].obs;     // Filtered + searched properties
  var searchQuery = ''.obs;                // User search text
  var activeFilter = FilterModel().obs;    // Currently applied filter

  @override
  void onInit() {
    super.onInit();
    _listenToProperties();

    // 🔄 Whenever search changes, re-apply filter and search logic together
    ever(searchQuery, (_) => _applyAllFilters());
  }

  /// 🔥 Fetch all properties from Firestore in real-time
  void _listenToProperties() {
    _firebaseService.fetchAllProperties().listen((properties) {
      propertyList.assignAll(properties);
      _applyAllFilters();
    });
  }

  /// ✅ Search + Filter combined logic
  void _applyAllFilters() {
    List<Property> list = propertyList;

    // Apply search filter (by location)
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((p) => p.location.toLowerCase().contains(query)).toList();
    }

    // Apply additional filters
    final filter = activeFilter.value;

    // Property Type
    if (filter.propertyType.isNotEmpty) {
      list = list
          .where((p) => p.propertyType.toLowerCase() == filter.propertyType.toLowerCase())
          .toList();
    }

    // Bedrooms
    if (filter.bedrooms.isNotEmpty) {
      list = list
          .where((p) => p.bedrooms.toLowerCase().contains(filter.bedrooms.toLowerCase()))
          .toList();
    }

    // Price Range
    if (filter.priceRange.isNotEmpty) {
      list = _filterByPriceRange(list, filter.priceRange);
    }

    filteredList.assignAll(list);
  }

  /// 🔍 Search only (for external triggers)
  void searchByLocation(String value) {
    searchQuery.value = value;
  }

  /// 🏡 Apply filters from FilterBottomSheet
  void applyFilter(FilterModel filter) {
    activeFilter.value = filter;
    _applyAllFilters();
  }

  /// 💰 Helper to filter price range
  List<Property> _filterByPriceRange(List<Property> list, String range) {
    try {
      return list.where((p) {
        final price = double.tryParse(p.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

        switch (range) {
          case '< ₹50k':
            return price < 50000;
          case '₹50k - ₹1L':
            return price >= 50000 && price <= 100000;
          case '₹1L - ₹2L':
            return price >= 100000 && price <= 200000;
          case '₹2L - ₹5L':
            return price >= 200000 && price <= 500000;
          case '> ₹5L':
            return price > 500000;
          default:
            return true;
        }
      }).toList();
    } catch (_) {
      return list;
    }
  }

  /// 🚿 Clear all filters and search
  void clearFilters() {
    searchQuery.value = '';
    activeFilter.value = FilterModel();
    filteredList.assignAll(propertyList);
  }
}

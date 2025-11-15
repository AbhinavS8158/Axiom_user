import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/filter_model.dart';
import 'package:user/model/property_card_model.dart';

class AllPropertyController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  var propertyList = <Property>[].obs; // All properties from Firestore
  var filteredList = <Property>[].obs; // Filtered properties
  var searchQuery = ''.obs;
  var activeFilter = FilterModel().obs;

  @override
  void onInit() {
    super.onInit();
    _listenToProperties();
    ever(searchQuery, (_) => _applyAllFilters());
  }

  /// 🔥 Fetch all properties in real time
  void _listenToProperties() {
    _firebaseService.fetchAllProperties().listen((properties) {
      propertyList.assignAll(properties);
      _applyAllFilters();
    });
  }

  /// ✅ Combined Search + Filter logic
  void _applyAllFilters() {
    List<Property> list = propertyList;
    final filter = activeFilter.value;

    // 🔍 Search by location
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list
          .where((p) => p.location.toLowerCase().contains(query))
          .toList();
    }

    // 🏷️ Filter by Services (For rent / For sell / For Pg)
    if (filter.services.isNotEmpty) {
      list = list.where((p) {
        final collection = p.collectiontype.toLowerCase();

        // normalize the filter to match Firestore naming
        if (filter.services.toLowerCase().contains('rent')) {
          return collection.contains('rent');
        } else if (filter.services.toLowerCase().contains('sell')) {
          return collection.contains('sell');
        } else if (filter.services.toLowerCase().contains('pg')) {
          return collection.contains('pg');
        }
        return true;
      }).toList();
    }

    // 🏢 Property Type filter
    if (filter.propertyType.isNotEmpty) {
      list = list
          .where((p) =>
              p.propertyType.toLowerCase() ==
              filter.propertyType.toLowerCase())
          .toList();
    }

    // 🛏️ Bedrooms
    if (filter.bedrooms.isNotEmpty) {
      list = list
          .where((p) =>
              p.bedrooms.toLowerCase().contains(filter.bedrooms.toLowerCase()))
          .toList();
    }

    // 💰 Price Range
    if (filter.priceRange.isNotEmpty) {
      list = _filterByPriceRange(list, filter.priceRange);
    }

    filteredList.assignAll(list);
  }

  /// 🔍 Search by text
  void searchByLocation(String value) {
    searchQuery.value = value;
  }

  /// 🏡 Apply filters from FilterBottomSheet
  void applyFilter(FilterModel filter) {
    activeFilter.value = filter;
    _applyAllFilters();
  }

  /// 💰 Helper to filter by price range
  List<Property> _filterByPriceRange(List<Property> list, String range) {
    try {
      return list.where((p) {
        final price =
            double.tryParse(p.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

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
 
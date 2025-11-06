import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user/model/property_card_model.dart';

class FavoritesController extends GetxController {
  final RxList<String> favoriteIds = <String>[].obs; // store property IDs
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Load saved favorites
    List? saved = _storage.read('favorites');
    if (saved != null) {
      favoriteIds.assignAll(saved.map((e) => e.toString()).toList());
    }

    // Auto-save whenever favorites change
    ever(favoriteIds, (_) => _storage.write('favorites', favoriteIds));
  }

  /// ❤️ Toggle favorite
  void toggleFavorite(Property property) {
    if (isFavorite(property.id)) {
      favoriteIds.remove(property.id);
    } else {
      favoriteIds.add(property.id);
    }
  }

  /// ✅ Check if property is favorite
  bool isFavorite(String propertyId) {
    return favoriteIds.contains(propertyId);
  }

  /// 🧹 Clear all favorites
  void clearFavorites() {
    favoriteIds.clear();
  }
}

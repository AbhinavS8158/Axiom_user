import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/model/property_card_model.dart';

class FavoritesController extends GetxController {
  final RxList<String> favoriteIds = <String>[].obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String? get _uid => _auth.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    _loadFavoritesForCurrentUser();
  }

  Future<void> _loadFavoritesForCurrentUser() async {
    if (_uid == null) {
      favoriteIds.clear();
      return;
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('favorites')
          .get();

      favoriteIds.assignAll(snapshot.docs.map((doc) => doc.id).toList());
      favoriteIds.refresh(); 
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> toggleFavorite(Property property) async {
  if (_uid == null) {
    Get.snackbar(
      'Login required',
      'Please login to manage wishlist',
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  final String propertyId = property.id.toString();

  final favoriteDocRef = _firestore
      .collection('users')
      .doc(_uid)
      .collection('favorites')
      .doc(propertyId);

  if (isFavorite(propertyId)) {
    favoriteIds.remove(propertyId);
    favoriteIds.refresh();

    await favoriteDocRef.delete();

    Get.snackbar(
      'Removed from Wishlist',
      '${property.title} removed successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  } else {
    favoriteIds.add(propertyId);
    favoriteIds.refresh();

    await favoriteDocRef.set({
      'propertyId': propertyId,
      'addedAt': FieldValue.serverTimestamp(),
      'title': property.title,
      'price': property.price,
    });

    Get.snackbar(
      'Added to Wishlist',
      '${property.title} added successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }
}


  bool isFavorite(String propertyId) {
    return favoriteIds.contains(propertyId.toString());
  }

  Future<void> clearFavorites() async {
    if (_uid == null) return;

    final batch = _firestore.batch();
    final favCollection = _firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites');

    final snapshot = await favCollection.get();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    favoriteIds.clear();
    favoriteIds.refresh();
  }
}

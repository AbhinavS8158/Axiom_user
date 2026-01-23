import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user/controller/cloudinary/cloudinary.dart';


class ProfileSectionController extends GetxController {
  // ---------------- STATE ----------------
  final isLoading = false.obs;
  final profileImageUrl = ''.obs;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  // ---------------- INIT ----------------
  void init(String phone) {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController(text: phone);

    _loadUserData();
  }

  // ---------------- LOAD USER ----------------
  Future<void> _loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      profileImageUrl.value = data['profileImage'] ?? '';
    }
  }

  // ---------------- PICK & UPLOAD IMAGE ----------------
  Future<void> pickAndUploadImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedImage == null) return;

    isLoading.value = true;

    try {
      final imageUrl = await _cloudinaryService.uploadImage(
        File(pickedImage.path),
      );

      profileImageUrl.value = imageUrl;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to upload image',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------- SAVE PROFILE ----------------
  Future<void> updateProfile() async {
  final uid = _auth.currentUser?.uid;
  if (uid == null) {
    Get.snackbar(
      'Error',
      'User not logged in',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
    );
    return;
  }

  try {
    isLoading.value = true;

    await _firestore.collection('users').doc(uid).set(
      {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'profileImage': profileImageUrl.value,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    // ✅ SUCCESS SNACKBAR
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.black,
      icon: const Icon(Icons.check_circle, color: Colors.green),
      duration: const Duration(seconds: 2),
    );

    // ✅ GO BACK AFTER SUCCESS
    Get.back();

  } catch (e) {
    // ❌ FAILURE SNACKBAR
    Get.snackbar(
      'Update Failed',
      'Unable to update profile. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.black,
      icon: const Icon(Icons.error, color: Colors.red),
      duration: const Duration(seconds: 3),
    );
  } finally {
    isLoading.value = false;
  }
}

  // ---------------- DISPOSE ----------------
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

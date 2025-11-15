import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user/model/property_card_model.dart';

class BookingController extends GetxController {
  // 🔹 Firebase instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔹 Form key
  final formKey = GlobalKey<FormState>();

  // 🔹 Text field controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  // 🔹 Reactive variables
  var moveInDate = Rxn<DateTime>();
  var selectedDuration = '6 Months'.obs;
  var agreeToTerms = false.obs;

  // 🔹 Available durations
  final durations = [
    '3 Months',
    '6 Months',
    '1 Year',
    '2 Years',
    'Long Term',
  ];

  // 🔹 Date picker
  Future<void> selectMoveInDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      moveInDate.value = picked;
    }
  }

  // 🔹 Format date for display
  String get formattedMoveInDate {
    if (moveInDate.value == null) return 'Select move-in date';
    return DateFormat('dd MMM yyyy').format(moveInDate.value!);
  }

  // 🔹 Toggle terms checkbox
  void toggleTerms(bool value) {
    agreeToTerms.value = value;
  }

  // 🔹 Submit booking (includes Firestore + status update)
 Future<bool> continueBooking(Property property) async {
  // Step 1️⃣ Validate form
  if (!formKey.currentState!.validate()) {
    Get.snackbar(
      "Form Incomplete",
      "Please fill all required fields.",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return false;
  }

  // Step 2️⃣ Validate move-in date
  if (moveInDate.value == null) {
    Get.snackbar(
      "Missing Move-In Date",
      "Please select a move-in date.",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return false;
  }

  // Step 3️⃣ Validate terms
  if (!agreeToTerms.value) {
    Get.snackbar(
      "Terms Required",
      "Please agree to the terms and conditions to proceed.",
      backgroundColor: Colors.orange,
      colorText: Colors.white,
    );
    return false;
  }

  // If everything is correct → allow the next page
  return true;
}


    // try {
    //   // Step 3️⃣ Show loading indicator
    //   Get.dialog(
    //     const Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false,
    //   );

    //   // Step 4️⃣ Save booking to Firestore
    //   await _firestore.collection('bookings').add({
    //     'propertyId': property.id,
    //     'propertyName': property.title,
    //     'userName': nameController.text.trim(),
    //     'userEmail': emailController.text.trim(),
    //     'userPhone': phoneController.text.trim(),
    //     'message': messageController.text.trim(),
    //     'moveInDate': moveInDate.value,
    //     'duration': selectedDuration.value,
    //     'createdAt': FieldValue.serverTimestamp(),
    //     'status': 'confirmed',
    //   });

    //   // Step 5️⃣ Update property status → 5 (booked)
    //   await _firestore.collection('properties').doc(property.id).update({
    //     'status': 5,
    //   });

    //   // Step 6️⃣ Close loader
    //   Get.back();

    //   // Step 7️⃣ Success feedback
    //   Get.snackbar(
    //     "Booking Confirmed 🎉",
    //     "Your booking for ${property.title} is successful!",
    //     backgroundColor: Colors.green,
    //     colorText: Colors.white,
    //     snackPosition: SnackPosition.TOP,
    //     duration: const Duration(seconds: 3),
    //   );

    //   // Step 8️⃣ Clear form fields
    //   clearForm();

    // } catch (e) {
    //   Get.back(); // close loader
    //   Get.snackbar(
    //     "Error",
    //     "Booking failed: $e",
    //     backgroundColor: Colors.redAccent,
    //     colorText: Colors.white,
    //   );
    // }
  

  // 🔹 Clear all form data
  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
    moveInDate.value = null;
    selectedDuration.value = '6 Months';
    agreeToTerms.value = false;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

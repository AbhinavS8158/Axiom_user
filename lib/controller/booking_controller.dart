import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/screens/bottomnav/bottom_nav.dart';

class BookingController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // 🔹 Form key
  final formKey = GlobalKey<FormState>();

  // 🔹 Text field controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final advanceAmountController = TextEditingController();

  // 🔹 Reactive variables
  var moveInDate = Rxn<DateTime>();
  var selectedDuration = '6 Months'.obs;
  var agreeToTerms = false.obs;
   final RxString advanceAmount = ''.obs;
   

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

  /// 🔹 Step 1: Validate form + extras based on property type
  Future<bool> continueBooking(Property property) async {
    final bool isSellProperty = property.collectiontype == "sell_property";

    // Validate form
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        "Form Incomplete",
        "Please fill all required fields.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    }

    // ✅ For rent/pg → need move-in date
    if (!isSellProperty) {
      if (moveInDate.value == null) {
        Get.snackbar(
          "Missing Move-In Date",
          "Please select a move-in date.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    }

    // ✅ For sell_property → need valid advance amount
    if (isSellProperty) {
      final txt = advanceAmountController.text.trim();
      final advance = int.tryParse(txt) ?? 0;
      if (advance <= 0) {
        Get.snackbar(
          "Invalid Advance",
          "Please enter a valid advance amount.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return false;
      }
    }

    // Validate terms
    if (!agreeToTerms.value) {
      Get.snackbar(
        "Terms Required",
        "Please agree to the terms and conditions to proceed.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    return true; // ✅ proceed to payment
  }

  /// 🔹 Step 2: After payment success → save booking + mark property booked
  Future<void> confirmBookingAndMarkPropertyBooked(
    Property property, {
    required int paidAmount,
  }) async {
    try {
      // Show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final user = _auth.currentUser;
      final userId = user?.uid ?? '';
      final bool isSellProperty =
          property.collectiontype == "sell_property";

      // 🧾 Save booking details
      final bookingRef =
      await _firestore.collection('bookings').add({
        'propertyId': property.id,
        'propertyName': property.title,
        'propertyOwnerId': property.userId,
        'userId': userId,
        'userName': nameController.text.trim(),
        'userEmail': emailController.text.trim(),
        'userPhone': phoneController.text.trim(),
        'message': messageController.text.trim(),
        'moveInDate': isSellProperty ? null : moveInDate.value,
        'duration': isSellProperty ? null : selectedDuration.value,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'booked',
        'bookingstatus': 'booked',
        'collectiontype': property.collectiontype,
        'paidAmount': paidAmount,
        'isAdvancePayment': isSellProperty,
      });
      final bookingId = bookingRef.id;

    await _firestore.collection('transactions').add({
  'bookingId': bookingId, // ✅ fixed typo
  'propertyId': property.id,
  'propertyName': property.title,
  'renterId': userId, // ✅ consistent with queries
  'ownerId': property.userId,
  'amount': paidAmount,
  'paymentType': isSellProperty ? 'advance' : 'full',
  'collectiontype': property.collectiontype, // ✅ consistent
  'status': 'success', // ✅ fixed typo
  'createdAt': FieldValue.serverTimestamp(),
  'duration': isSellProperty ? null : selectedDuration.value, // optional
});


      // 🏠 Update the correct property collection to mark as booked
      final collectionName = property.collectiontype;
      await _firestore.collection(collectionName).doc(property.id).update({
        'bookingstatus': 'booked',
      });

      // Close loader
      Get.back();

      // Success message
      Get.snackbar(
        "Booking Confirmed 🎉",
        "Your booking for ${property.title} is successful!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );

      // Clear form fields
      clearForm();
    } catch (e) {
      Get.back(); // close loader
      Get.snackbar(
        "Error",
        "Booking failed: $e",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
 Future<DocumentSnapshot?> getBookingForProperty(
  String propertyId,
) async {
  try {
    final renterId = _auth.currentUser?.uid;
    if (renterId == null) return null;

    final querySnapshot = await _firestore
        .collection('bookings') // ✅ CORRECT
        .where('propertyId', isEqualTo: propertyId)
        .where('renterId', isEqualTo: renterId)
        .where('bookingstatus', isEqualTo: 'booked')
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) return null;

    return querySnapshot.docs.first;
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to load booking: $e",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return null;
  }
}


  /// 🔹 Step 3: Cancel booking → update booking + property status
 /// 🔹 Step 3: Cancel booking → show confirm dialog, then update booking + property status
Future<void> cancelBooking({
  required BuildContext context,
  required String bookingId,
  required Property property,
}) async {
  Get.dialog(
    AlertDialog(
      title: const Text("Cancel Booking"),
      content: const Text(
        "Are you sure you want to cancel this booking?",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text("No"),
        ),
       TextButton(
  onPressed: () async {
    // 1️⃣ Close the dialog immediately
    Navigator.of(context).pop();

    try {
      // 2️⃣ Update booking
      await _firestore
          .collection('bookings')
          .doc(bookingId)
          .update({
        'status': 'cancelled',
        'bookingstatus': 'not booked',
        'cancelledAt': FieldValue.serverTimestamp(),
      });

      // 3️⃣ Update property availability
      await _firestore
          .collection(property.collectiontype)
          .doc(property.id)
          .update({
        'bookingstatus': 'not booked',
      });

      // 4️⃣ Show snackbar (safe, native)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking cancelled successfully"),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );

      // 5️⃣ Navigate to BottomNav → 2nd tab
   Get.offAll(() => BottomNav());

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to cancel booking. Please try again."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  },
  child: const Text(
    "Yes, Cancel",
    style: TextStyle(color: Colors.red),
  ),
),

      ],
    ),
    barrierDismissible: false,
  );
}


  // 🔹 Clear all form data
  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
    advanceAmountController.clear();
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
    advanceAmountController.dispose();
    super.onClose();
  }
}

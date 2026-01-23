import 'dart:async';

import 'package:get/get.dart';
import 'package:user/controller/services/firestore_service.dart';
import 'package:user/model/booking_model.dart';
import 'package:user/model/property_card_model.dart';

class BookingListController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();

  final RxList<Property> bookedProperties = <Property>[].obs;
  final RxList<Booking> userBookings = <Booking>[].obs;

  final RxBool isLoading = true.obs;

  StreamSubscription? _bookingSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchBookedProperties();
  }

  @override
  void onClose() {
    _bookingSubscription?.cancel();
    super.onClose();
  }

  void fetchBookedProperties() {
    isLoading.value = true;

    _bookingSubscription =
        _firebaseService.fetchUserBookings().listen((bookings) async {
      userBookings.assignAll(bookings);

      List<Property> properties = [];

      for (final booking in bookings) {
        final property =
            await _firebaseService.fetchPropertyByBooking(booking);
        if (property != null) {
          properties.add(property);
        }
      }

      bookedProperties.assignAll(properties);
      isLoading.value = false;
    });
  }

  /// ✅ Get booking document using propertyId
  Booking? getBookingByPropertyId(String propertyId) {
    try {
      return userBookings.firstWhere(
        (booking) => booking.propertyId == propertyId,
      );
    } catch (_) {
      return null;
    }
  }


}

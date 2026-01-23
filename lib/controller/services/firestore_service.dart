import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user/model/booking_model.dart';
import 'package:user/model/property_card_model.dart';
import 'package:user/model/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 Fetch rent properties
  Stream<List<Property>> fetchproperty() {
    return _firestore
        .collection('rent_property')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((doc) => Property.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// 🔹 Fetch sell properties
  Stream<List<Property>> fetchsellproperty() {
    return _firestore
        .collection('sell_property')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((doc) => Property.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// 🔹 Fetch PG properties
  Stream<List<Property>> fetchpgproperty() {
    return _firestore
        .collection('pg_property')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((doc) => Property.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// ✅ Combined stream
  Stream<List<Property>> fetchAllProperties() {
    return Rx.combineLatest3<
        List<Property>,
        List<Property>,
        List<Property>,
        List<Property>>(
      fetchproperty(),
      fetchsellproperty(),
      fetchpgproperty(),
      (rent, sell, pg) => [...rent, ...sell, ...pg],
    );
  }


//  Stream<List<Property>> fetchbookingproperty() {
//     return _firestore
//         .collection('bookings')
//         .snapshots()
//         .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       return snapshot.docs
//           .map((doc) => Property.fromMap(doc.data(), doc.id))
//           .toList();
//     });
//   }


 Stream<List<Booking>> fetchUserBookings() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: uid)
        .where('bookingstatus', isEqualTo: 'booked')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Booking.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// 2️⃣ Fetch property using booking data
  Future<Property?> fetchPropertyByBooking(Booking booking) async {
    final doc = await _firestore
        .collection(booking.collectiontype)
        .doc(booking.propertyId)
        .get();

    if (!doc.exists) return null;

    return Property.fromMap(doc.data()!, doc.id);
  }



  
Stream<AppUser?> fetchCurrentUser() {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  if (uid == null) {
    return const Stream.empty();
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((doc) {
        if (!doc.exists) return null;
        return AppUser.fromMap(doc.data()!, doc.id);
      });
}


}

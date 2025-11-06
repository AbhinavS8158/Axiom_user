import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user/model/property_card_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Fetch rent properties
  Stream<List<Property>> fetchproperty() {
    return _firestore.collection('rent_property').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Property.fromMap(data, doc.id);
      }).toList();
    });
    
  }

  /// 🔹 Fetch sell properties
  Stream<List<Property>> fetchsellproperty() {
    return _firestore.collection('sell_property').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Property.fromMap(data, doc.id);
      }).toList();
    });
  }

  /// 🔹 Fetch PG properties
  Stream<List<Property>> fetchpgproperty() {
    return _firestore.collection('pg_property').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Property.fromMap(data, doc.id);
      }).toList();
    });
  }

   


  /// ✅ Combined Stream — merges rent, sell, and pg properties
  Stream<List<Property>> fetchAllProperties() {
    return Rx.combineLatest3<List<Property>, List<Property>, List<Property>, List<Property>>(
      fetchproperty(),
      fetchsellproperty(),
      fetchpgproperty(),
      (rent, sell, pg) {
        // Combine all property types into a single list
        final all = [...rent, ...sell, ...pg];
        return all;
      },
    );
  }
}

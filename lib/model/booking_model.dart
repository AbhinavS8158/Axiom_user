

import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String propertyId;
  final String collectiontype;
  final String userId;
  final String bookingstatus;
  final DateTime date;

  Booking({
    required this.id,
    required this.propertyId,
    required this.collectiontype,
    required this.userId,
    required this.bookingstatus,
    required this.date,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String id) {
    return Booking(
      id: id,
      propertyId: data['propertyId'],
      collectiontype: data['collectiontype'],
      userId: data['userId'],
      bookingstatus: data['bookingstatus'],
      date: (data['createdAt']as Timestamp).toDate(),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistory {
  final String id; 
  final String bookingId;
  final String propertyId;
  final String propertyName;
  final String renterId;
  final String ownerId;
  final int amount;
  final String paymentType; 
  final String collectiontype;
  final String status; 
  final DateTime createdAt;

  TransactionHistory({
    required this.id,
    required this.bookingId,
    required this.propertyId,
    required this.propertyName,
    required this.renterId,
    required this.ownerId,
    required this.amount,
    required this.paymentType,
    required this.collectiontype,
    required this.status,
    required this.createdAt,
  });

  factory TransactionHistory.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return TransactionHistory(
      id: doc.id,
      bookingId: data['bookingId'] ?? '',
      propertyId: data['propertyId'] ?? '',
      propertyName: data['propertyName'] ?? '',
      renterId: data['renterId'] ?? '',
      ownerId: data['ownerId'] ?? '',
      amount: (data['amount'] ?? 0) is int
          ? data['amount']
          : int.tryParse(data['amount'].toString()) ?? 0,
      paymentType: data['paymentType'] ?? '',
      collectiontype: data['collectiontype'] ?? '',
      status: data['status'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'propertyId': propertyId,
      'propertyName': propertyName,
      'renterId': renterId,
      'ownerId': ownerId,
      'amount': amount,
      'paymentType': paymentType,
      'collectiontype': collectiontype,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

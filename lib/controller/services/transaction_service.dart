import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user/model/transaction_model.dart';

class TransactionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Stream transactions for the logged-in user
  Stream<List<TransactionHistory>> getTransactionsForUser(String userId) {
    return _firestore
        .collection('transactions') // ✅ FIXED
        .where('renterId', isEqualTo: userId) // ✅ FIXED
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TransactionHistory.fromDoc(doc))
              .toList();
        });
  }
}

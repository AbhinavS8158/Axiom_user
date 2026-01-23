import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:user/controller/services/transaction_service.dart';
import 'package:user/model/transaction_model.dart';

class TransactionController extends GetxController {
  final TransactionService _service = TransactionService();

  final RxList<TransactionHistory> transactions = <TransactionHistory>[].obs;
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _listenToTransactions();
  }

  void _listenToTransactions() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      error.value = 'User not logged in';
      isLoading.value = false;
      return;
    }

    _subscription = _service
        .getTransactionsForUser(userId)
        .listen((data) {
          transactions.assignAll(data);
          isLoading.value = false;
        }, onError: (e) {
          error.value = e.toString();
          isLoading.value = false;
        });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

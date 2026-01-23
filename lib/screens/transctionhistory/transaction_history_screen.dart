import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/transction_controller.dart';
import 'package:user/screens/transctionhistory/transaction_card_widget.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({super.key});

  final TransactionController controller =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        if (controller.transactions.isEmpty) {
          return const Center(child: Text('No transactions found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            return buildTransactionCard(
              controller.transactions[index],
            );
          },
        );
      }),
    );
  }
}

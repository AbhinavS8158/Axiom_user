 import 'package:flutter/material.dart';
import 'package:user/model/transaction_model.dart';

Widget buildTransactionCard(TransactionHistory transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
           Icons.arrow_upward ,
          color: Colors.green,
        ),
        title: Text(
          transaction.propertyName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          _formatDate(transaction.createdAt),
          style: TextStyle(color: Colors.grey[400], fontSize: 12),
        ),
        trailing: Text(
          _formatAmount(transaction.amount.toDouble()),
          style: TextStyle(
            color:  Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    final sign = amount > 0 ? '+' : '-';
    return '$sign ₹${amount.abs().toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
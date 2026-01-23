import 'package:flutter/material.dart';

class PaymentFailedPage extends StatelessWidget {
  const PaymentFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 120, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Payment Failed!",
              style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

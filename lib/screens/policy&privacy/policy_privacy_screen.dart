import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColor.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Privacy Matters',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '''
We respect your privacy and are fully committed to protecting your personal data. This Privacy Policy explains how we collect, use, store, and safeguard your information when you use our application and related services.

When you use our app, we may collect certain information that is necessary to provide a smooth and secure user experience. This may include basic account details, contact information, and data related to your interactions within the app. We also collect technical information such as device details and usage data to improve app performance, functionality, and reliability. We do not collect sensitive personal information unless it is explicitly required for a specific feature and provided voluntarily by you.

Your information is used solely for legitimate purposes, including account management, service delivery, customer support, communication, and improving our features. We do not sell, rent, or trade your personal data to third parties. Data may only be shared with trusted service providers when necessary to operate the app, and always under strict confidentiality agreements.

We implement appropriate technical and organizational security measures to protect your data against unauthorized access, alteration, disclosure, or destruction. However, no digital platform can guarantee complete security.

By using our app, you agree to the terms of this Privacy Policy. We may update this policy periodically, and any changes will be communicated through the app.
''',
                style: TextStyle(fontSize: 14, color: AppColor.grey6),
              ),
              const SizedBox(height: 16),
              const Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '• Account information\n'
                '• Contact details\n'
                '• Property interaction data\n'
                '• App usage data',
                style: TextStyle(fontSize: 14, color: AppColor.grey6),
              ),
              const SizedBox(height: 16),
              const Text(
                'Data Security',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '''We implement industry-standard security measures to protect your data from unauthorized access, misuse, alteration, or disclosure. These measures include secure data storage, controlled access to information, and regular system monitoring. While we continuously work to enhance our security practices, no method of data transmission or storage can be guaranteed to be completely secure.''',
                style: TextStyle(fontSize: 14, color: AppColor.grey6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

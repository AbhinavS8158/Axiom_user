import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/screens/utils/app_color.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const String supportPhone = '1800-00-70-300';

  Future<void> _callSupport() async {
    final Uri uri = Uri.parse('tel:$supportPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  static const String supportEmail = 'support@axiom.com';

Future<void> _sendEmail() async {
  final Uri uri = Uri(
    scheme: 'mailto',
    path: supportEmail,
    query: 'subject=Support Request',
  );

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColor.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSupportCard(),
            const SizedBox(height: 16),
           _buildEmailCard(),
            const SizedBox(height: 16),
           
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
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
      child: Row(
        children: [
          const Icon(Icons.support_agent,
              size: 28, color: AppColor.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Support',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Facing an issue? Our support team is here to help you.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColor.grey6,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: _callSupport,
                  child: Text(
                    'Missed call: $supportPhone',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildEmailCard() {
  return Container(
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
    child: Row(
      children: [
        const Icon(Icons.email_outlined,
            size: 28, color: AppColor.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _sendEmail,
                child: Text(
                  supportEmail,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  // Widget _buildCard({
  //   required IconData icon,
  //   required String title,
  //   required String description,
  // }) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: AppColor.white,
  //       borderRadius: BorderRadius.circular(16),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 10,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Icon(icon, size: 28, color: AppColor.primary),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColor.black,
  //                 ),
  //               ),
  //               const SizedBox(height: 6),
  //               Text(
  //                 description,
  //                 style: TextStyle(
  //                   fontSize: 13,
  //                   color: AppColor.grey6,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

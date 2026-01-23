import 'package:flutter/material.dart';
import 'package:user/screens/utils/app_color.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const Text(
          'About Us',
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
                'About Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '''
Axiom is a comprehensive real estate property booking application designed to simplify the way users discover, book, and manage properties. The platform brings rental properties, properties for sale, and PG accommodations into a single, easy-to-use digital solution.

Our goal is to make property searching and booking transparent, efficient, and reliable. Axiom enables users to explore verified listings, view detailed property information, and complete bookings with confidence. Whether users are searching for a home to rent, a property to buy, or a PG stay, Axiom offers a streamlined and secure experience.

We focus on clarity, trust, and usability. Every feature is built with the user in mind, ensuring smooth navigation, accurate information, and dependable performance. Data privacy and secure transactions are central to our platform, allowing users to interact and book with peace of mind.

Axiom is designed to bridge the gap between property owners, service providers, and customers by delivering a modern real estate solution that is efficient, scalable, and future-ready.''',
                style: TextStyle(fontSize: 14, color: AppColor.grey6),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

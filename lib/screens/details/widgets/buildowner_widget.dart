import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildOwnerSection(String id) {
    if (id.isEmpty) return _ownerNotAvailable();

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("service_provider")
          .doc(id) // property.id MUST match service_provider.id
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return _ownerNotAvailable();
        }

        // Check ID match
        if (snapshot.data!.id != id) {
          return _ownerNotAvailable();
        }

        var data = snapshot.data!.data() as Map<String, dynamic>;

        return _ownerCard(
          data["profileImage"] ?? "",
          data["username"] ?? "Agent",
          data["phone"] ?? "",
        );
      },
    );
  }


  // OWNER INFO LOADER
  

  // OWNER CARD WIDGET
  Widget _ownerCard(String img, String name, String phone) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.grey1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.grey3,
            backgroundImage: img.isNotEmpty ? NetworkImage(img) : null,
            child: img.isEmpty
                ? Icon(Icons.person, size: 30, color: AppColor.blue)
                : null,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                 Text("Contact for property details",
                    style: TextStyle(fontSize: 14, color: AppColor.grey)),
              ],
            ),
          ),

          IconButton(
            icon: Icon(Icons.phone, color: AppColor.blue),
            onPressed: () {
              if (phone.isNotEmpty) {
                launchUrl(Uri.parse("tel:$phone"));
              }
            },
          ),

          IconButton(
            icon: Icon(Icons.message, color: AppColor.blue),
            onPressed: () {
              if (phone.isNotEmpty) {
                launchUrl(Uri.parse("sms:$phone"));
              }
            },
          ),
        ],
      ),
    );
  }

  // OWNER NOT AVAILABLE
  Widget _ownerNotAvailable() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.grey1,
        borderRadius: BorderRadius.circular(12),
      ),
      child:  Text(
        "Owner information not available",
        style: TextStyle(color: AppColor.fav, fontSize: 14),
      ),
    );
  }


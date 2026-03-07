import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/screens/chat/chat.dart';
import 'package:user/screens/utils/app_color.dart';

Widget buildOwnerSection(String id) {
  if (id.isEmpty) return _ownerNotAvailable();

  return FutureBuilder<DocumentSnapshot>(
    future: FirebaseFirestore.instance
        .collection("service_provider")
        .doc(id)
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || !snapshot.data!.exists) {
        return _ownerNotAvailable();
      }

      final data = snapshot.data!.data() as Map<String, dynamic>;

      return _ownerCard(
        snapshot.data!.id,             
        data["profileImage"] ?? "",
        data["username"] ?? "Agent",
        data["phone"] ?? "",
      );
    },
  );
}

Widget _ownerCard(
  String providerId,
  String img,
  String name,
  String phone,
) {
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
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Contact for property details",
                style: TextStyle(fontSize: 14, color: AppColor.grey),
              ),
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
            Get.to(
              () => Chat(
                providerId: providerId,
                providerName: name,
                providerImg: img,
                 providerPhone: phone,
              ),
            );
          },
        ),
        IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.whatsapp,
            color: Color(0xFF25D366),
          ),
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

Widget _ownerNotAvailable() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColor.grey1,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      "Owner information not available",
      style: TextStyle(color: AppColor.fav, fontSize: 14),
    ),
  );
}

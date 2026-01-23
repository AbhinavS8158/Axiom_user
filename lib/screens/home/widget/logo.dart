import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/screens/chat/chat_list.dart';
import 'package:user/screens/utils/app_color.dart';

class Logo extends StatelessWidget {
  final String currentUserId;

  const Logo({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'AXIOM',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(
                () => ChatList(currentUserId: currentUserId),
              );
            },
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
        ],
      ),
    );
  }
}

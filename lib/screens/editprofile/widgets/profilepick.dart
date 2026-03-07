import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/profile_section_controller.dart';

class Profilepick extends StatelessWidget {
  const Profilepick({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileSectionController>();

    return Obx(() {
      final imageUrl = controller.profileImageUrl.value;

      return Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : const NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                  ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: controller.pickAndUploadImage,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),

          if (controller.isLoading.value)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      );
    });
  }
}

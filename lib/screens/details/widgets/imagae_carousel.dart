import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/controller/image_carousel_controller.dart';
import 'package:user/screens/utils/app_color.dart'; // adjust the path

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageCarouselController());

    if (imageUrls.isEmpty) {
      return Container(
        color: AppColor.grey3,
        child:  Center(
          child: Icon(Icons.image, size: 80, color: AppColor.grey),
        ),
      );
    }

    return Stack(
      children: [
        PageView.builder(
          itemCount: imageUrls.length,
          onPageChanged: controller.updateIndex,
          itemBuilder: (context, index) {
            return Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            (progress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stack) => Container(
                color: AppColor.grey3,
                child:  Center(
                  child: Icon(Icons.broken_image, size: 60, color: AppColor.grey),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColor.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.image, color: AppColor.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${controller.currentIndex.value + 1}/${imageUrls.length}',
                      style: const TextStyle(
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

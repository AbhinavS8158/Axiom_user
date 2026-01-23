import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:user/controller/image_carousel_controller.dart';
import 'package:user/screens/utils/app_color.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;
  final ImageCarouselController controller = Get.put(ImageCarouselController());

  ImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: double.infinity,
            viewportFraction: 1.0,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 20),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
            },
          ),
          items:
              imageUrls.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox.expand(
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image: url,
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.contain,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Image.asset(
                            'assets/images/placeholder.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
        ),

        // --- Image Counter ---
        Positioned(
          bottom: 10,
          right: 10,
          child: Obx(() {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${controller.currentIndex.value + 1} / ${imageUrls.length}',
                style: const TextStyle(
                  color: AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),

        // --- Image Indicator Dots ---
        Positioned(
          bottom: 12,
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageUrls.length, (index) {
                return Container(
                  width: controller.currentIndex.value == index ? 12 : 8,
                  height: controller.currentIndex.value == index ? 12 : 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        controller.currentIndex.value == index
                            ? AppColor.blue
                            : AppColor.grey,
                  ),
                );
              }),
            );
          }),
        ),
      ],
    );
  }
}

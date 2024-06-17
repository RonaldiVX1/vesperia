import 'package:carousel_slider/carousel_slider.dart';
import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/features/onboarding/component/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Image.asset(
            "assets/images/img_onboarding.png",
            height: 400,
          ),
          const SizedBox(height: 50),
          CarouselSlider(
            carouselController: controller.carouselController,
            items: const [
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.", textAlign: TextAlign.center),
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.", textAlign: TextAlign.center),
              Text("Ipsum is simply dummy text of the printing and typesetting industry.", textAlign: TextAlign.center),
            ],
            options: CarouselOptions(
              height: 100,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                controller.setCurrentIndex(index);
              },
            ),
          ),
          carouselIndicator(),
          const SizedBox(height: 30),
          buttonCarousel(),
        ]),
      ),
    );
  }

  Widget buttonCarousel() {
    return Obx(() {
      if (controller.currentIndex == 2) {
        return OutlinedButton(
            onPressed: () {
              controller.closeOnboarding();
            },
            child: const Text("Continue"));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
              onPressed: () {
                controller.closeOnboarding();
              },
              child: const Text("Skip")),
          OutlinedButton(
              onPressed: () {
                controller.nextPage();
              },
              style: OutlinedButton.styleFrom(backgroundColor: primary),
              child: const Text("Next", style: TextStyle(color: white)))
        ],
      );
    });
  }

  Widget carouselIndicator() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            dotIndicator(0),
            dotIndicator(1),
            dotIndicator(2),
          ],
        ),
      ],
    );
  }

  Widget dotIndicator(
    int index,
  ) {
    return Obx(() => Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(
            right: 10,
          ),
          decoration: BoxDecoration(shape: BoxShape.circle, color: controller.currentIndex == index ? primary : gray600),
        ));
  }
}

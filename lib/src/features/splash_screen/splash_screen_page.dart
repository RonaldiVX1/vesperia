import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/features/splash_screen/component/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SplashScreenPage extends GetView<SplashScreenController> {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [primary, green600], begin: Alignment.topCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Obx(() => Text("Ver: ${controller.appVersion.value}")),
          ],
        ),
      ),
    );
  }
}

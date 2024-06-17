import 'dart:async';

import 'package:entrance_test/app/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../repositories/user_repository.dart';

class SplashScreenController extends GetxController {
  final UserRepository _userRepository;

  SplashScreenController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final appVersion = ''.obs;
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    delayedSplash();
    getPackageInfo();
  }

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    debugPrint(packageInfo.version);
    appVersion.value = packageInfo.version;
  }

  Future delayedSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (await Get.find<UserRepository>().checkUserLogin()) {
      Get.offAllNamed(RouteName.dashboard);
    } else {
      Get.offAllNamed(RouteName.onboarding);
    }
  }
}

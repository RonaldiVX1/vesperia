import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/splash_screen/component/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_storage/get_storage.dart';

import '../../../repositories/user_repository.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(SplashScreenController(
      userRepository: Get.find<UserRepository>(),
    ));
  }
}

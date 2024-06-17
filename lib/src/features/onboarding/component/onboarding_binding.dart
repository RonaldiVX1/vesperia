import 'package:dio/dio.dart';
import 'package:entrance_test/src/features/onboarding/component/onboarding_controller.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserRepository(
      client: Get.find<Dio>(),
      local: Get.find<GetStorage>(),
    ));

    Get.put(OnboardingController(
      userRepository: Get.find<UserRepository>(),
    ));
  }
}

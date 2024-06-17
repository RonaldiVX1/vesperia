import 'package:carousel_slider/carousel_slider.dart';
import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final UserRepository _userRepository;

  OnboardingController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final carouselController = CarouselController();

  final _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  @override
  void onInit() {
    super.onInit();
    checkOnboarding();
  }

  void setCurrentIndex(int index) {
    _currentIndex.value = index;
  }

  void incrementIndex() {
    _currentIndex.value++;
  }

  void nextPage() {
    carouselController.nextPage();
  }

  void skipCarousel() {
    carouselController.animateToPage(2);
  }

  Future<void> checkOnboarding() async {
    if (await Get.find<UserRepository>().checkOnboarding()) {
      Get.offAllNamed(RouteName.login);
    } else {}
  }

  void closeOnboarding() {
    _userRepository.closeOnboarding();
    Get.offAllNamed(RouteName.login);
  }
}

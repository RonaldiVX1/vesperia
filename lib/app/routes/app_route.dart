import 'package:entrance_test/app/routes/route_name.dart';
import 'package:entrance_test/src/features/dashboard/component/dashboard_binding.dart';
import 'package:entrance_test/src/features/dashboard/dashboard_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/edit/edit_profile_page.dart';
import 'package:entrance_test/src/features/dashboard/profile/web_view/Web_View_Screen.dart';
import 'package:entrance_test/src/features/detail_product/component/detail_product_binding.dart';
import 'package:entrance_test/src/features/detail_product/detail_product_screen.dart';
import 'package:entrance_test/src/features/onboarding/component/onboarding_binding.dart';
import 'package:entrance_test/src/features/onboarding/onboarding_screen.dart';
import 'package:entrance_test/src/features/splash_screen/component/splash_screen_binding.dart';
import 'package:entrance_test/src/features/splash_screen/splash_screen_page.dart';
import 'package:get/get.dart';

import '../../src/features/dashboard/profile/edit/component/edit_profile_binding.dart';
import '../../src/features/login/component/login_binding.dart';
import '../../src/features/login/login_page.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: RouteName.detailProduct,
      page: () => const DetailProductScreen(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: RouteName.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: RouteName.webPage,
      page: () => const WebViewScreen(),
    ),
    GetPage(
      name: RouteName.splashPage,
      page: () => const SplashScreenPage(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: RouteName.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBinding(),
    ),
  ];
}

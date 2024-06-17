import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();
  final dialCode = "62".obs;
  final isProcessLogin = false.obs;

  final hidePassword = true.obs;
  void showPassword() {
    hidePassword.value = !hidePassword.value;
  }

  void getValidity() {}

  void doLogin() async {
    if (etPhone.text.length < 8 || etPhone.text.length > 16) {
      SnackbarWidget.showFailedSnackbar('Nomor handphone tidak sesuai');
      return;
    } else if (etPassword.text.length < 8) {
      SnackbarWidget.showFailedSnackbar('Password tidak sesuai');
      return;
    } else if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
      SnackbarWidget.showFailedSnackbar('Email atau password salah');
      return;
    }

    isProcessLogin.value = true;
    await _userRepository.login(
      etPhone.text,
      etPassword.text,
      dialCode.value,
    );
    isProcessLogin.value = false;
    Get.offAllNamed(RouteName.dashboard);
  }
}

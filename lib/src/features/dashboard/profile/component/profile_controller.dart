import 'dart:io';

import 'package:dio/dio.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../app/routes/route_name.dart';
import '../../../../utils/networking_util.dart';
import '../../../../widgets/snackbar_widget.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository;

  final _name = "".obs;

  String get name => _name.value;

  final _phone = "".obs;

  String get phone => _phone.value;

  final _profilePictureUrl = "".obs;

  String get profilePictureUrl => _profilePictureUrl.value;

  final _localPath = "".obs;
  final _permissionReady = false.obs;
  late TargetPlatform? platform;

  ProfileController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  void onInit() {
    super.onInit();
    loadUserFromServer();
    getPlatform();
  }

  void getPlatform() {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath.value = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath.value);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  void loadUserFromServer() async {
    try {
      final response = await _userRepository.getUser();
      if (response.status == 0) {
        final localUser = response.data;

        _name.value = localUser.name;
        _phone.value = localUser.countryCode.isNotEmpty ? "+${localUser.countryCode}${localUser.phone}" : "";
        _profilePictureUrl.value = localUser.profilePicture ?? '';
      } else {
        SnackbarWidget.showFailedSnackbar(response.message);
      }
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage(error));
    }
  }

  onEditProfileClick() async {
    Get.toNamed(RouteName.editProfile);
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  onTestUnauthenticatedClick() async {
    await _userRepository.testUnauthenticated();
  }

  onDownloadFileClick() async {
    _permissionReady.value = await _checkPermission();
    if (_permissionReady.value) {
      await _prepareSaveDir();
      print("Downloading");
      try {
        await Dio().download(
          "https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf",
          _localPath + "/" + "tutorial.pdf",
        );
        print("Download Completed.");
      } catch (e) {
        print("Download Failed.\n\n" + e.toString());
      }
    }
  }

  onOpenWebPageClick() {
    Get.toNamed(RouteName.webPage);
  }

  void doLogout() async {
    await _userRepository.logout();
    Get.offAllNamed(RouteName.login);
  }
}

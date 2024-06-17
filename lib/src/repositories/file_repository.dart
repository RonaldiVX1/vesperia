import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileRepository {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  void initState() {
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
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
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
}

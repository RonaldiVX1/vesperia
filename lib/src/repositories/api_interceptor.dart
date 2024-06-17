import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../../app/routes/route_name.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      Get.find<GetStorage>().remove('user_credentials');
      Get.offAllNamed(RouteName.login);
    } else {
      handler.next(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Get.find<GetStorage>().remove('user_credentials');
      Get.offAllNamed(RouteName.login);
    } else {
      handler.next(err);
    }
  }
}

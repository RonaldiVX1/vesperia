import 'package:dio/dio.dart';
import 'package:entrance_test/src/constants/local_data_key.dart';
import 'package:entrance_test/src/models/response/login_response_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/endpoint.dart';
import '../models/response/user_response_model.dart';
import '../utils/networking_util.dart';

class UserRepository {
  final Dio _client;
  final GetStorage _local;

  final isLoggedIn = false.obs;

  UserRepository({required Dio client, required GetStorage local})
      : _client = client,
        _local = local;

  Future<void> login(String phoneNumber, String password, String countryCode) async {
    try {
      final responseJson = await _client.post(Endpoint.login, data: {
        "phone_number": phoneNumber,
        "password": password,
        "country_code": countryCode,
      });
      // final model = UserResponseModel.fromJson(responseJson.data);
      // _local.write(LocalDataKey.token, model);
      final model = LoginResponseModel.fromJson(responseJson.data);
      _local.write(LocalDataKey.token, model.data!.token);
    } on DioException catch (_) {
      rethrow;
    }

    //Artificial delay to simulate logging in process
    await Future.delayed(const Duration(seconds: 2));
    //Placeholder token. DO NOT call real logout API using this token
  }

  Future<bool> checkOnboarding() async {
    if (_local.read(LocalDataKey.onboarding) != null) {
      return true;
    }
    return false;
  }

  Future<void> closeOnboarding() async {
    await _local.write(LocalDataKey.onboarding, "onboarded");
  }

  Future<void> logout() async {
    //Artificial delay to simulate logging out process
    await Future.delayed(const Duration(seconds: 2));
    await _local.remove(LocalDataKey.token);
  }

  Future<bool> checkUserLogin() async {
    if (_local.read(LocalDataKey.token) != null) {
      return true;
    }
    return false;
  }

  Future<UserResponseModel> getUser() async {
    try {
      final responseJson = await _client.get(
        Endpoint.getUser,
        options: NetworkingUtil.setupNetworkOptions('Bearer ${_local.read(LocalDataKey.token)}'),
      );
      final model = UserResponseModel.fromJson(responseJson.data);
      // _local.write(LocalDataKey.token, model);
      return model;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /*
    This Function is used as challenge tester
    DO NOT modify this function
   */
  Future<void> testUnauthenticated() async {
    try {
      final realToken = _local.read<String?>(LocalDataKey.token);
      await _local.write(LocalDataKey.token, '621|kM5YBY5yM15KEuSmSMaEzlfv0lWs83r4cp4oty2T');
      getUser();
      //401 not caught as exception
      await _local.write(LocalDataKey.token, realToken);
    } on DioException catch (_) {
      rethrow;
    }
  }
}

import 'package:entrance_test/src/models/login_model.dart';

import '../error_model.dart';

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  final int? status;
  final String? message;
  final LoginModel? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? LoginModel.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        if (status != null) 'status': status,
        if (message != null) 'message': message,
        if (data != null) 'data': data!.toJson(),
      };
}

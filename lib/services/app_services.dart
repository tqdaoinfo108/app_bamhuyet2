import 'dart:convert';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/base_response.dart';
import '../model/type_service_model.dart';
import '../model/user_model.dart';
import 'http_auth_basic.dart';

class AppServices {
  late http.Client _api;
  static const String _baseURL = "http://apihoanglambamhuyet.gvbsoft.com/";
  AppServices._privateConstructor() {
    _api =
        BasicAuthClient("UserAPIOtoTrackingStore", "PassAPIOtoTrackingStore");
  }

  static Map get getAuth => {
        "UserID": GetStorage().read(userUserID),
        "UUSerID": GetStorage().read(userUserName)
      };

  static final AppServices _instance = AppServices._privateConstructor();

  static AppServices get instance => _instance;

  Future<ResponseBase<UserModel>?> letLogin(
      String userName, String passWord) async {
    try {
      var data = json.encode({"UserName": userName, "PassWord": passWord});
      var rawResponse =
          await _api.post(Uri.parse("${_baseURL}api/user/login"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> getProfile() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/user/profile?userID=${GetStorage().read(userUserID)}"));
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> letRegister(
      String phone) async {
    try {
      var data = json.encode({
        "UserName": phone
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/register"), body: data);
      if (rawResponse.statusCode == 200 &&
          json.decode(rawResponse.body)["message"] == null) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> letUpdateUser(
      Map<String, dynamic> data) async {
    try {
      var rawResponse = await _api.post(Uri.parse("${_baseURL}api/user/update"),
          body: jsonEncode(data));
      if (rawResponse.statusCode == 200 &&
          json.decode(rawResponse.body)["message"] == null) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<TypeServiceModel>>?> getTypeServices() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/typeservice/get-list?page=1&limit=100"));
      if (rawResponse.statusCode == 200) {
        return TypeServiceModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<ServiceModel>>?> getServices(int typeServiceID) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/service/get-list-services?typeServiceID=$typeServiceID&page=1&limit=100"));
      if (rawResponse.statusCode == 200) {
        return ServiceModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> postVerifyOTP(String otp) async {
    try {
      var data = json.encode({
        "OTP": otp
      });
      var rawResponse = await _api.post(Uri.parse(
          "${_baseURL}api/user/verify-otp"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

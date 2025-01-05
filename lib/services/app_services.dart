import 'dart:convert';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/base_response.dart';
import '../model/user_model.dart';
import 'http_auth_basic.dart';

class AppServices {
  late http.Client _api;
  static const String _baseURL = "http://apichatwiththeo.gvbsoft.vn/";
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

  Future<ResponseBase<UserModel>?> letRegister(String email, String passWord,
      String phone, String fullName, int positionID) async {
    try {
      var data = json.encode({
        "ImagePath": "",
        "PositionID": positionID,
        "UserName": email,
        "PassWord": passWord,
        "FullName": fullName,
        "Email": email,
        "Address": "",
        "Phone": phone,
        "StatusID": 1,
        "NumberLogin": 0,
        "LastLogin": DateTime.now().toString()
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
}

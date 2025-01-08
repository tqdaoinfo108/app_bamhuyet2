import 'dart:convert';
import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/base_response.dart';
import '../model/branch_model.dart';
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

  Future<ResponseBase<UserModel>?> letRegister(String phone) async {
    try {
      var data = json.encode({"UserName": phone});
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
      var rawResponse = await _api.get(
          Uri.parse("${_baseURL}api/typeservice/get-list?page=1&limit=100"));
      if (rawResponse.statusCode == 200) {
        return TypeServiceModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<ServiceModel>>?> getServices(
      int typeServiceID) async {
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
      var data = json.encode({"OTP": otp});
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/verify-otp"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<CityModel>>?> getListCity() async {
    try {
      var rawResponse =
          await _api.get(Uri.parse("${_baseURL}api/city/get-list-all"));
      if (rawResponse.statusCode == 200) {
        return CityModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<ProvinceModel>>?> getListProvice(int cityID) async {
    try {
      var rawResponse = await _api
          .get(Uri.parse("${_baseURL}api/provice/get-list?cityID=$cityID"));
      if (rawResponse.statusCode == 200) {
        return ProvinceModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> updateParther({
    required String imageRoot,
    required String fullName,
    required int yearBirthday,
    required int cityID,
    required int provinceID,
    required bool genderID,
    required String description,
    required String image2,
    required String image3,
    required String image4,
  }) async {
    try {
      var data = json.encode({
        "ImagePath": imageRoot,
        "FullName": fullName,
        "YearBirthday": yearBirthday,
        "CountryID": 1,
        "CityID": cityID,
        "ProviceID": provinceID,
        "GenderID": genderID,
        "Description": description,
        "lstImages": [image2, image3, image4]
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/update-to-parner"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  Future<ResponseBase<BranchModel>?> updateBranch({
    required String imageRoot,
    required String fullName,
    required int cityID,
    required int provinceID,
    required String description,
    required String address,
    required String image2,
    required String image3,
    required String image4,
    required TimeOfDay timeOfDay1,
    required TimeOfDay timeOfDay2,
    required TimeOfDay timeOfDay3,
    required TimeOfDay timeOfDay4,
    required String ws,
    required String fb,
    required String tiktok,
    required String instagram,
    required String youtube,
  }) async {
    try {
      var data = json.encode({
        "ImagePath": imageRoot,
        "Phone": "000000",
        "BranchName": fullName,
        "CountryID": 1,
        "CityID": cityID,
        "ProviceID": provinceID,
        "Description": description,
        "lstImages": [image2, image3, image4],
        "Address": address,
        "TimeStart26":
            timeOfDayToDateTime(timeOfDay1, DateTime.now()).toIso8601String(),
        "TimeEnd26":
            timeOfDayToDateTime(timeOfDay2, DateTime.now()).toIso8601String(),
        "TimeStart7CN":
            timeOfDayToDateTime(timeOfDay3, DateTime.now()).toIso8601String(),
        "TimeEnd7CN":
            timeOfDayToDateTime(timeOfDay4, DateTime.now()).toIso8601String(),
        "Website": ws,
        "FaceBook": fb,
        "Youtube": youtube,
        "Tiktox": tiktok,
        "Instagram": instagram,
        "LatMap": 0,
        "IngMap": 0,
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/branch/branch-create"), body: data);
      if (rawResponse.statusCode == 200) {
        return BranchModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  
  Future<ResponseBase<List<ServiceModel>>?> getServicesAll() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/service/get-list-service-active?page=1&limit=1000"));
      if (rawResponse.statusCode == 200) {
        return ServiceModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }


  Future<ResponseBase<String>?> uploadFile(String imagePath) async {
    try {
      final url = Uri.parse('$_baseURL/api/fileupload/upload');

      final req = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('', imagePath));

      req.headers['Content-Type'] = 'multipart/form-data';

      final stream = await req.send();
      final res = await http.Response.fromStream(stream);
      final status = res.statusCode;
      if (status != 200) {
        throw Exception('http.send error: statusCode= $status');
      }
      return ResponseBase<String>.fromJson(jsonDecode(res.body));
    } catch (e) {
      return null;
    }
  }
}

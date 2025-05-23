import 'dart:convert';
import 'package:app_bamnguyet_2/model/address_model.dart';
import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/history_model.dart';
import 'package:app_bamnguyet_2/model/money_input_model.dart';
import 'package:app_bamnguyet_2/model/news_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/base_response.dart';
import '../model/booking_model.dart';
import '../model/booking_price_model.dart';
import '../model/branch_model.dart';
import '../model/rating_model.dart';
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
        "UUSerID": GetStorage().read(userUserName),
        "UserName": GetStorage().read(userUserName)
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
        var result = UserModel.getFromJson(json.decode(rawResponse.body));
        GetStorage box = new GetStorage();
        box.write(userUserName, result.data!.userName);
        box.write(userFullName, result.data!.fullName);
        box.write(userImagePath, result.data!.imagePath);
        box.write(userUserID, result.data!.userID);
        box.write(userTypeUser, result.data!.typeUserID);
        box.write(userUserAmount, result.data!.totalAmount);
        return result;
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
      if (rawResponse.statusCode == 200) {
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
    required int? branch,
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
      var _data = {
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
      };
      if (branch != null) {
        _data["BranchID"] = branch;
      }
      http.Response rawResponse;

      var data = json.encode(_data);
      rawResponse = branch != null
          ? await _api.post(Uri.parse("${_baseURL}api/branch/branch-update"),
              body: data)
          : await _api.post(Uri.parse("${_baseURL}api/branch/branch-create"),
              body: data);
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

  Future<ResponseBase<BranchModel>?> getBranchByID(int branchID) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/branch/get-branch-by-id?branchID=$branchID"));
      if (rawResponse.statusCode == 200) {
        return BranchModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<BranchModel>?> addService(
      int branchID, List<LstServiceDetails> listPrice) async {
    try {
      var data = json
          .encode({"BranchID": branchID, "lstServiceBranchAmount": listPrice});
      var rawResponse = await _api.post(
          Uri.parse("${_baseURL}api/branch/add-update-service-to-branch"),
          body: data.replaceAll('\"', '"'));
      if (rawResponse.statusCode == 200) {
        return BranchModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> addServicetoPartner(
      List<int> listPrice) async {
    try {
      var data = json.encode({"lstServiceID": listPrice});
      var rawResponse = await _api.post(
          Uri.parse("${_baseURL}api/user/add-service-to-parner"),
          body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<AddressModel>>?> getListAddress() async {
    try {
      var rawResponse = await _api.get(
          Uri.parse("${_baseURL}api/useraddress/get-list?page=1&limit=100"));
      if (rawResponse.statusCode == 200) {
        return AddressModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<AddressModel>?> saveAddress(
      String name, String phone, String address, String description,
      {int? addressID}) async {
    try {
      var data = {
        "NameContact": name,
        "Phone": phone,
        "Address": address,
        "IngMap": 0,
        "LatMap": 0,
        "Description": description
      };
      var path = "api/useraddress/created";
      if (addressID != null) {
        data["UserAddressID"] = addressID;
        path = "api/useraddress/update";
      }

      var rawResponse = await _api.post(Uri.parse("${_baseURL}$path"),
          body: json.encode(data));
      if (rawResponse.statusCode == 200) {
        return AddressModel.getFromJsonObject(jsonDecode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<bool>?> deleteAddress(int addressID) async {
    try {
      var data = json.encode({"UserAddressID": addressID});

      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/useraddress/delete"), body: data);
      if (rawResponse.statusCode == 200) {
        return ResponseBase.fromJson(jsonDecode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<UserModel>>?> getListPartner() async {
    try {
      // var data = json.encode({"lstServiceID": listPrice});
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/user/get-list-user-partners?page=1&limit=30"));
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJsonList(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<UserModel>>?> getListCustomer(
      {String keySearch = ""}) async {
    try {
      // var data = json.encode({"lstServiceID": listPrice});
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/user/get-list-user?key=$keySearch&typeUserID=4&page=1&limit=10000"));
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJsonList(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<BookingModel>?> createBooking(
      {required int serviceID,
      required int addressID,
      required String minute,
      required double amount,
      required DateTime time,
      int? branchID,
      int? userIDBooking,
      int? userIDProcess,
      String? description}) async {
    try {
      var data = {
        "TypeBookingID": 1,
        "UserID_Booking": userIDBooking,
        "UserID_Proccess": userIDProcess,
        "BranchID_Process": branchID,
        "UserAddressID": addressID,
        "ServiceID": serviceID,
        "Minute": minute,
        "Amount": amount,
        "AmountDiscount": amount,
        "DateStart": time.toIso8601String(),
        "Description": description ?? ""
      };
      var path = "api/booking/create";
      var rawResponse = await _api.post(Uri.parse("${_baseURL}$path"),
          body: json.encode(data));
      if (rawResponse.statusCode == 200) {
        return BookingModel.getFromJsonObject(jsonDecode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<BookingModel>>?> getListBooking(
      {required double lat,
      required double lng,
      required DateTime dateTime,
      required int page}) async {
    try {
      var path =
          "api/booking/get-booking-by-date?dateGet=${dateTime.toIso8601String()}&Latitude=$lat&Longitude=$lng&page=$page&limit=40";
      var rawResponse = await _api.get(Uri.parse("${_baseURL}$path"));
      if (rawResponse.statusCode == 200) {
        return BookingModel.getFromJsonList(jsonDecode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String?> getCountBooking() async {
    try {
      var path = "api/booking/count-booking-waiting";
      var rawResponse = await _api.get(Uri.parse("${_baseURL}$path"));
      if (rawResponse.statusCode == 200) {
        return rawResponse.body;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<BookingModel?> postPartnerReciveBooking(
      {required int bookingID}) async {
    try {
      var data = {"BookingID": bookingID};
      var path = "api/booking/partner-recive-booking";
      var rawResponse = await _api.post(Uri.parse("${_baseURL}$path"),
          body: json.encode(data));
      if (rawResponse.statusCode == 200) {
        var rs = jsonDecode(rawResponse.body);
        if (rs["status"] != null) {
          return BookingModel()..bookingId = -1;
        }
        return BookingModel.fromJson(rs);
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

  Future<ResponseBase<List<RatingModel>>?> getListRating(
      int typeServiceID) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/rating/get-rating-average-by-type-service?typeServiceID=${typeServiceID}&page=1&limit=20"));
      if (rawResponse.statusCode == 200) {
        return RatingModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<HistoryModel>>?> getHistory() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/booking/get-booking-by-user?page=1&limit=40"));
      if (rawResponse.statusCode == 200) {
        return HistoryModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> createPassword(String password) async {
    try {
      var data = json.encode({
        "UserName": "string",
        "PassWordNew": password,
        "PassWordNewAgain": password
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/create-pass"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<NewsModel>>?> getNewsList(int type) async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/news/get-list-news?contentTypeID=2&page=1&limit=1"));
      if (rawResponse.statusCode == 200) {
        return NewsModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<MoneyInputModel>>?> getListMoneyInput() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/money-input/get-list-pagging?page=1&limit=20"));
      if (rawResponse.statusCode == 200) {
        return MoneyInputModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> postCreateMoneyInput(double price) async {
    try {
      var data = json.encode({"Amount": price});
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/money-input/create"), body: data);
      if (rawResponse.statusCode == 200) {
        return json.decode(rawResponse.body)["data"] != null;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> postFinalBooking(int bookingID) async {
    try {
      var data = json.encode({"BookingID": bookingID});
      var rawResponse = await _api.post(
          Uri.parse("${_baseURL}api/booking/partner-update-final"),
          body: data);
      if (rawResponse.statusCode == 200) {
        return json.decode(rawResponse.body) != null;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> postRate(int bookingID, String description, int level) async {
    try {
      var data = json.encode({
        "auth": {
          "UserID": GetStorage().read(userUserID),
          "UUSerID": GetStorage().read(userUserName)
        },
        "data": {
          "BookingID": bookingID,
          "LevelID": level,
          "Description": description,
          "DateCreated": DateTime.now().toIso8601String()
        }
      });
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/rating/create"), body: data);
      if (rawResponse.statusCode == 200) {
        return json.decode(rawResponse.body) != null;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateProfile(UserModel model, String fullName) async {
    try {
      var rawResponse = await _api.post(Uri.parse("${_baseURL}api/user/update"),
          body: json.encode(model.toJson(fullName)));
      if (rawResponse.statusCode == 200) {
        var result = UserModel.getFromJson(json.decode(rawResponse.body));

        GetStorage box = new GetStorage();
        box.write(userUserName, result.data!.userName);
        box.write(userFullName, result.data!.fullName);
        box.write(userImagePath, result.data!.imagePath);
        box.write(userUserID, result.data!.userID);
        box.write(userTypeUser, result.data!.typeUserID);
        box.write(userUserAmount, result.data!.totalAmount);

        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<PriceBooking?> postGetPrice(int bookingID) async {
    var data = json.encode({"BookingID": bookingID});

    try {
      var rawResponse = await _api.post(
          Uri.parse("${_baseURL}api/booking/get-amount-remain"),
          body: data);
      if (rawResponse.statusCode == 200) {
        return PriceBooking.fromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<UserModel>?> postUpdateAvt(String avatar) async {
    var data = json.encode({"ImagesPaths": avatar});

    try {
      var rawResponse = await _api
          .post(Uri.parse("${_baseURL}api/user/upload-avatar"), body: data);
      if (rawResponse.statusCode == 200) {
        return UserModel.getFromJson(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<ResponseBase<List<BranchModel>>?> getBranch() async {
    try {
      var rawResponse = await _api.get(Uri.parse(
          "${_baseURL}api/branch/get-list-branch-active?page=1&limit=100"));
      if (rawResponse.statusCode == 200) {
        return BranchModel.getFromJsonList(json.decode(rawResponse.body));
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> deleteUser() async {
    try {
      var userID = GetStorage().read(userUserID);
      var rawResponse = await _api
          .get(Uri.parse("${_baseURL}api/user/delete?UserID=$userID"));
      if (rawResponse.statusCode == 200) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<void> getListConfig() async {
    try {
      var rawResponse =
          await _api.get(Uri.parse("${_baseURL}api/config/get-list-all"));
      if (rawResponse.statusCode == 200) {
        for (var item in jsonDecode(rawResponse.body)["data"]) {
          if (item["ConfigKey"] == "IsRelease") {
            var isRelease2 = item["ConfigValue"] == "true";
            GetStorage box = new GetStorage();
            box.write(isRelease, isRelease2);
          }
        }
      }
    } catch (e) {}
  }
}

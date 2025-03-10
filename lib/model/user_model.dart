import 'base_response.dart';
import 'service_model.dart';

class UserModel {
  int userID = 0;
  String? codeInvite;
  String? codePersonInvite;
  String? imagePath;
  // int? branchID;
  int typeUserID = 0;
  String userName = "";
  String fullName = "";
  bool? genderID;
  String? address;
  // int? ingUser;
  // int? latUser;
  // bool? isActive;
  bool? confirmPhone;
  bool? confirmPartner;
  // String? lastLogin;
  String? oTP = "1234";
  String? timeOTP;
  // bool? isDeleted;
  List<LstImageUsers> lstImageUsers = [];
  List<LstServiceDetails> lstServiceUsers = [];
  List<int> lstBranchId = [];
  int cityId = 0;
  int proviceId = 0;
  int yearBirthday = 0;
  double totalAmount = 0;
  String? description;

  UserModel();

  Map<String, dynamic> toJson(String inputFullName) {

    final Map<String, dynamic> _auth = <String, dynamic>{};
    _auth["UserID"] = userID;
    _auth["UUSerID"] = fullName;

    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserID"] = userID;
    _data["CodeInvite"] = codeInvite;
    _data["CodePersonInvite"] = codePersonInvite;
    _data["ImagePath"] = imagePath;
    _data["TypeUserID"] = typeUserID;
    _data["UserName"] = userName;
    _data["FullName"] = inputFullName;
    _data["GenderID"] = genderID;
    _data["Address"] = address;
    _data["IsActive"] = true;
    _data["ConfirmPhone"] = confirmPhone;
    _data["ConfirmPartner"] = confirmPartner;
    _data["LastLogin"] = DateTime.now().toIso8601String();
    _data["OTP"] = "";
    _data["TimeOTP"] = DateTime.now().toIso8601String();

    final Map<String, dynamic> _full = <String, dynamic>{};
    _full["auth"] = _auth;
    _full["data"] = _data;
    return _full;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    codeInvite = json['CodeInvite'];
    codePersonInvite = json['CodePersonInvite'];
    imagePath = json['ImagePath'];
    // branchID = json['BranchID'];
    typeUserID = json['TypeUserID'];
    userName = json['UserName'];
    fullName = json['FullName'];
    genderID = json['GenderID'];
    address = json['Address'];
    // ingUser = json['IngUser'];
    // latUser = json['LatUser'];
    // isActive = json['IsActive'];
    confirmPhone = json['ConfirmPhone'];
    confirmPartner = json['ConfirmPartner'];
    // lastLogin = json['LastLogin'];
    oTP = json['OTP'];
    timeOTP = json['TimeOTP'];
    cityId = json["CityID"] ?? 0;
    proviceId = json["ProviceID"] ?? 0;
    yearBirthday = json["YearBirthday"];
    description = json["Description"];
    totalAmount = json["TotalAmount"] ?? 0;
    lstImageUsers = json["lstImageUsers"] == null
        ? []
        : (json["lstImageUsers"] as List)
            .map((e) => LstImageUsers.fromJson(e))
            .toList();
    lstServiceUsers = json["lstServiceUsers"] == null
        ? []
        : (json["lstServiceUsers"] as List)
            .map((e) => LstServiceDetails.fromJson(e))
            .toList();
    lstBranchId =
        json["lstBranchID"] == null ? [] : List<int>.from(json["lstBranchID"]);

    // isDeleted = json['IsDeleted'];
  }

  static ResponseBase<UserModel> getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<UserModel>(
        data: UserModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase()..message = json["message"] ;
    }
  }

  static ResponseBase<List<UserModel>>? getFromJsonList(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <UserModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(UserModel.fromJson(v));
        });
      }
      return ResponseBase<List<UserModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}

class LstImageUsers {
  int? userId;
  String? imagePath;

  LstImageUsers.fromJson(Map<String, dynamic> json) {
    userId = json["UserID"];
    imagePath = json["ImagePath"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserID"] = userId;
    _data["ImagePath"] = imagePath;
    return _data;
  }
}

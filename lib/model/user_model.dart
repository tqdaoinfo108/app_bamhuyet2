import '../services/app_services.dart';
import 'base_response.dart';

class UserModel {
  int? userID;
  String? imagesPaths;
  int? typeUserID;
  int? positionID;
  String? userName;
  String? fullName;
  String? email;
  String? address;
  String? phone;
  int? statusID;
  int? numberLogin;
  String? lastLogin;

  UserModel(
      {this.userID,
      this.imagesPaths,
      this.typeUserID,
      this.positionID,
      this.userName,
      this.fullName,
      this.email,
      this.address,
      this.phone,
      this.statusID,
      this.numberLogin,
      this.lastLogin});

  Map<String, dynamic> toJsonUpdate(String _fullName,
      String _address, String _phone, String _email, int _positionID) {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserID"] = userID;
    _data["ImagePath"] = imagesPaths;
    _data["TypeUserID"] = typeUserID;
    _data["PositionID"] = _positionID;
    _data["UserName"] = userName;
    _data["FullName"] = _fullName;
    _data["Email"] = _email;
    _data["Address"] = _address;
    _data["Phone"] = _phone;
    _data["StatusID"] = 1;
    _data["NumberLogin"] = numberLogin;
    _data["LastLogin"] = lastLogin;

    final Map<String, dynamic> _data2 = <String, dynamic>{};
    _data2["auth"] = AppServices.getAuth;
    _data2["data"] = _data;

    return _data2;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    imagesPaths = json['ImagesPaths'];
    typeUserID = json['TypeUserID'];
    positionID = json['PositionID'];
    userName = json['UserName'];
    fullName = json['FullName'];
    email = json['Email'];
    address = json['Address'];
    phone = json['Phone'];
    statusID = json['StatusID'];
    numberLogin = json['NumberLogin'];
    lastLogin = json['LastLogin'];
  }

  static ResponseBase<UserModel> getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<UserModel>(
        data: UserModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase();
    }
  }
}
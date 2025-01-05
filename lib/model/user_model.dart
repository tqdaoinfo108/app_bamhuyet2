import 'base_response.dart';

class UserModel {
  int userID = 0;
  String? codeInvite;
  String? codePersonInvite;
  String? imagePath;
  // int? branchID;
  // int? typeUserID;
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
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    codeInvite = json['CodeInvite'];
    codePersonInvite = json['CodePersonInvite'];
    imagePath = json['ImagePath'];
    // branchID = json['BranchID'];
    // typeUserID = json['TypeUserID'];
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
    // isDeleted = json['IsDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.userID;
    // data['CodeInvite'] = this.codeInvite;
    data['CodePersonInvite'] = this.codePersonInvite;
    data['ImagePath'] = this.imagePath;
    // data['BranchID'] = this.branchID;
    // data['TypeUserID'] = this.typeUserID;
    data['UserName'] = this.userName;
    data['FullName'] = this.fullName;
    data['GenderID'] = this.genderID;
    data['Address'] = this.address;
    // data['IngUser'] = this.ingUser;
    // data['LatUser'] = this.latUser;
    // data['IsActive'] = this.isActive;
    data['ConfirmPhone'] = this.confirmPhone;
    data['ConfirmPartner'] = this.confirmPartner;
    // data['LastLogin'] = this.lastLogin;
    data['OTP'] = this.oTP;
    data['TimeOTP'] = this.timeOTP;
    // data['IsDeleted'] = this.isDeleted;
    return data;
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

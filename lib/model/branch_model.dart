
import 'base_response.dart';

class BranchModel {
    int? branchId;
    int? userId;
    // String? imagePath;
    // String? branchName;
    // dynamic nameContact;
    // String? phone;
    // String? address;
    // int? countryId;
    // int? cityId;
    // int? proviceId;
    // String? timeStart26;
    // String? timeEnd26;
    // String? timeStart7Cn;
    // String? timeEnd7Cn;
    // String? website;
    // String? faceBook;
    // String? youtube;
    // String? tiktox;
    // String? instagram;
    // int? latMap;
    // int? ingMap;
    // String? description;

    BranchModel.fromJson(Map<String, dynamic> json) {
        branchId = json["BranchID"];
        userId = json["UserID"];
        // imagePath = json["ImagePath"];
        // branchName = json["BranchName"];
        // nameContact = json["NameContact"];
        // phone = json["Phone"];
        // address = json["Address"];
        // countryId = json["CountryID"];
        // cityId = json["CityID"];
        // proviceId = json["ProviceID"];
        // timeStart26 = json["TimeStart26"];
        // timeEnd26 = json["TimeEnd26"];
        // timeStart7Cn = json["TimeStart7CN"];
        // timeEnd7Cn = json["TimeEnd7CN"];
        // website = json["Website"];
        // faceBook = json["FaceBook"];
        // youtube = json["Youtube"];
        // tiktox = json["Tiktox"];
        // instagram = json["Instagram"];
        // latMap = json["LatMap"];
        // ingMap = json["IngMap"];
        // description = json["Description"];
    }
    
    static ResponseBase<BranchModel> getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<BranchModel>(
        data: BranchModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase();
    }
  }
}
import 'base_response.dart';
import 'service_model.dart';

class BranchModel {
  int? branchId;
  int? userId;
  String? imagePath;
  String? branchName;
  dynamic nameContact;
  String? phone;
  String? address;
  int? countryId;
  int? cityId;
  int? proviceId;
  String? timeStart26;
  String? timeEnd26;
  String? timeStart7Cn;
  String? timeEnd7Cn;
  String? website;
  String? faceBook;
  String? youtube;
  String? tiktox;
  String? instagram;
  double? latMap;
  double? ingMap;
  String? description;
  List<LstBranchImages>? lstBranchImages;
  List<LstServiceDetails> lstServiceUsers = [];

  BranchModel(
      {this.branchId,
      this.userId,
      this.imagePath,
      this.branchName,
      this.nameContact,
      this.phone,
      this.address,
      this.countryId,
      this.cityId,
      this.proviceId,
      this.timeStart26,
      this.timeEnd26,
      this.timeStart7Cn,
      this.timeEnd7Cn,
      this.website,
      this.faceBook,
      this.youtube,
      this.tiktox,
      this.instagram,
      this.latMap,
      this.ingMap,
      this.description,
      this.lstBranchImages});

  BranchModel.fromJson(Map<String, dynamic> json) {
    branchId = json["BranchID"];
    userId = json["UserID"];
    imagePath = json["ImagePath"];
    branchName = json["BranchName"];
    nameContact = json["NameContact"];
    phone = json["Phone"];
    address = json["Address"];
    countryId = json["CountryID"];
    cityId = json["CityID"];
    proviceId = json["ProviceID"];
    timeStart26 = json["TimeStart26"];
    timeEnd26 = json["TimeEnd26"];
    timeStart7Cn = json["TimeStart7CN"];
    timeEnd7Cn = json["TimeEnd7CN"];
    website = json["Website"];
    faceBook = json["FaceBook"];
    youtube = json["Youtube"];
    tiktox = json["Tiktox"];
    instagram = json["Instagram"];
    latMap = json["LatMap"];
    ingMap = json["IngMap"];
    description = json["Description"];
    lstBranchImages = json["lstBranchImages"] == null
        ? null
        : (json["lstBranchImages"] as List)
            .map((e) => LstBranchImages.fromJson(e))
            .toList();

    lstServiceUsers = json["lstServiceUsers"] == null
        ? []
        : (json["lstServiceUsers"] as List)
        .map((e) => LstServiceDetails.fromJson(e))
        .toList();
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

class LstBranchImages {
  String? imagePath;

  LstBranchImages.fromJson(Map<String, dynamic> json) {
    imagePath = json["ImagePath"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ImagePath"] = imagePath;
    return _data;
  }
}

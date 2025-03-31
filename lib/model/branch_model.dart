import 'package:intl/intl.dart';

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
  List<LstServiceDetails> lstBranchServices = [];

  String get getTime26 {
    var time1 = DateFormat('HH:mm').format(DateTime.parse(timeStart26!));
    var time2 = DateFormat('HH:mm').format(DateTime.parse(timeEnd26!));

    return "$time1 -$time2";
  }

  String get getTime7 {
    var time1 = DateFormat('HH:mm').format(DateTime.parse(timeStart7Cn!));
    var time2 = DateFormat('HH:mm').format(DateTime.parse(timeEnd7Cn!));

    return "$time1 -$time2";
  }

  List<String> get ImagePathList {
    List<String> imagePaths = [];

    // Thêm imagePath chính nếu nó không null và không rỗng
    if (imagePath != null && imagePath!.isNotEmpty) {
      imagePaths.add(imagePath!);
    }

    // Thêm tất cả imagePath từ lstBranchImages nếu danh sách không null
    if (lstBranchImages != null) {
      imagePaths.addAll(
        lstBranchImages!
            .map((image) => image.imagePath)
            .where((path) => path != null && path.isNotEmpty)
            .cast<String>(),
      );
    }

    return imagePaths;
  }

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

    lstBranchServices = json["lstBranchServices"] == null
        ? []
        : (json["lstBranchServices"] as List)
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

  static ResponseBase<List<BranchModel>>? getFromJsonList(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <BranchModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(BranchModel.fromJson(v));
        });
      }
      return ResponseBase<List<BranchModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
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

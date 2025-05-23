import 'package:intl/intl.dart';

import 'base_response.dart';

class ServiceModel {
  int serviceID = 0;
  String serviceName = "";
  String imagePath = "";
  double amount = 0;
  bool isExpand = false;
  int? branchID;
  String? phoneContact;
  // double amountDiscount = 0;
  // bool? isActive;
  // String? shortDescription;
  // String? description;
  List<LstServiceDetails> lstServiceDetails = [];

  ServiceModel(this.serviceID, this.serviceName, this.imagePath, this.amount,
      this.lstServiceDetails, this.phoneContact, this.branchID
      // this.isActive,
      // this.shortDescription,
      // this.description
      );

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceID = json['ServiceID'];
    serviceName = json['ServiceName'];
    imagePath = json['ImagePath'];
    amount = json['Amount'] ?? 0;
    phoneContact = json['PhoneContact'];
    // isActive = json['IsActive'];
    // shortDescription = json['ShortDescription'];
    // description = json['Description'];
    lstServiceDetails = (json["lstServiceDetails"] == null
            ? null
            : (json["lstServiceDetails"] as List)
                .map((e) => LstServiceDetails.fromJson(e))
                .toList()) ??
        [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceID'] = this.serviceID;
    data['ServiceName'] = this.serviceName;
    data['ImagePath'] = this.imagePath;
    data['Amount'] = this.amount;
    // data['IsActive'] = this.isActive;
    // data['ShortDescription'] = this.shortDescription;
    // data['Description'] = this.description;

    return data;
  }

  static ResponseBase<List<ServiceModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ServiceModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ServiceModel.fromJson(v));
        });
      }
      return ResponseBase<List<ServiceModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}

class LstServiceDetails {
  int? serviceDetailId;
  int? serviceId;
  String? minute;
  double? amount;
  String? imageBranchService;

  String get amountFormatString =>
      NumberFormat.decimalPattern('vi').format(amount) + "đ";

  String? description;
  bool isChoose = false;
  String get getAmount => NumberFormat.decimalPattern('vi').format(amount);
  LstServiceDetails(
      {this.serviceDetailId,
      this.serviceId,
      this.minute,
      this.amount,
      this.description,
      this.imageBranchService});

  LstServiceDetails.fromJson(Map<String, dynamic> json) {
    serviceDetailId = json["ServiceDetailID"];
    serviceId = json["ServiceID"];
    minute = json["Minute"];
    amount = json["Amount"];
    description = json["Description"] ?? "";
    imageBranchService = json["ImageBranchService"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ServiceDetailID"] = serviceDetailId;
    _data["ServiceID"] = serviceId;
    _data["Minute"] = minute;
    _data["Amount"] = amount;
    _data["Description"] = description;
    _data["ImageBranchService"] = imageBranchService;
    return _data;
  }
}

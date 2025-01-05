
import 'base_response.dart';

class ServiceModel {
  int serviceID = 0;
  String serviceName = "";
  String imagePath = "";
  double? amount = 0;
  double amountDiscount = 0;
  // bool? isActive;
  // String? shortDescription;
  // String? description;

  ServiceModel(
      this.serviceID,
      this.serviceName,
      this.imagePath,
      this.amount,
      this.amountDiscount,
      // this.isActive,
      // this.shortDescription,
      // this.description
      );

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceID = json['ServiceID'];
    serviceName = json['ServiceName'];
    imagePath = json['ImagePath'];
    amount = json['Amount'];
    amountDiscount = json['AmountDiscount'];
    // isActive = json['IsActive'];
    // shortDescription = json['ShortDescription'];
    // description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ServiceID'] = this.serviceID;
    data['ServiceName'] = this.serviceName;
    data['ImagePath'] = this.imagePath;
    data['Amount'] = this.amount;
    data['AmountDiscount'] = this.amountDiscount;
    // data['IsActive'] = this.isActive;
    // data['ShortDescription'] = this.shortDescription;
    // data['Description'] = this.description;
    return data;
  }

  
  static ResponseBase<List<ServiceModel >>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ServiceModel >[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ServiceModel .fromJson(v));
        });
      }
      return ResponseBase<List<ServiceModel >>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
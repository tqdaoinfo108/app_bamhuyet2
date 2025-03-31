import 'base_response.dart';

class TypeServiceModel {
  int typeServiceID = 0;
  String typeServiceName = "";
  String imagePath = "";
  int typeID = 1;
  // bool? isActive;
  // String? description;

  TypeServiceModel(
    this.typeServiceID,
    this.typeServiceName,
    this.imagePath,
    // this.isActive,
    // this.description
  );

  TypeServiceModel.fromJson(Map<String, dynamic> json) {
    typeServiceID = json['TypeServiceID'];
    typeServiceName = json['TypeServiceName'];
    imagePath = json['ImagePath'];
    typeID = json ['TypeID'];
    // isActive = json['IsActive'];
    // description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeServiceID'] = this.typeServiceID;
    data['TypeServiceName'] = this.typeServiceName;
    data['ImagePath'] = this.imagePath;

    // data['IsActive'] = this.isActive;
    // data['Description'] = this.description;
    return data;
  }

  static ResponseBase<List<TypeServiceModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <TypeServiceModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(TypeServiceModel.fromJson(v));
        });
      }
      return ResponseBase<List<TypeServiceModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}

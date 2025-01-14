import 'package:app_bamnguyet_2/model/base_response.dart';

class AddressModel {
  int userAddressId = 0;
  String nameContact = "";
  String phone = "";
  String address = "";
  double ingMap = 0;
  double latMap = 0;
  String description = "";

  AddressModel.fromJson(Map<String, dynamic> json) {
    userAddressId = json["UserAddressID"];
    nameContact = json["NameContact"];
    phone = json["Phone"];
    address = json["Address"];
    ingMap = json["IngMap"];
    latMap = json["LatMap"];
    description = json["Description"];
  }

  static ResponseBase<List<AddressModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <AddressModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(AddressModel.fromJson(v));
        });
      }
      return ResponseBase<List<AddressModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
  static ResponseBase<AddressModel> getFromJsonObject(Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<AddressModel>(
        data: AddressModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase();
    }
  }
}

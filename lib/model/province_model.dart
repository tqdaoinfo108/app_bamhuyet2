import 'base_response.dart';

class ProvinceModel {
  int? proviceId;
  int? cityId;
  String? proviceName;

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    proviceId = json["ProviceID"];
    cityId = json["CityID"];
    proviceName = json["ProviceName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ProviceID"] = proviceId;
    _data["CityID"] = cityId;
    _data["ProviceName"] = proviceName;
    return _data;
  }

  static ResponseBase<List<ProvinceModel>>? getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <ProvinceModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(ProvinceModel.fromJson(v));
        });
      }
      return ResponseBase<List<ProvinceModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }

   @override
  String toString() {
    return proviceName ?? "";
  }
}

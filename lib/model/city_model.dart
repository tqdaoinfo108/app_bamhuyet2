import 'base_response.dart';

class CityModel {
  int? cityId;
  String? cityName;

  CityModel({this.cityId, this.cityName});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json["CityID"];
    cityName = json["CityName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["CityID"] = cityId;
    _data["CityName"] = cityName;
    return _data;
  }

  static ResponseBase<List<CityModel>>? getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <CityModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(CityModel.fromJson(v));
        });
      }
      return ResponseBase<List<CityModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
  @override
  String toString() {
    return cityName ?? "";
  }
}

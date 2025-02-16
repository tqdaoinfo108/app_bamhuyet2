
import 'base_response.dart';

class RatingModel {
  int? userId;
  String? fullName;
  String? imagePath;
  // int? cityId;
  // String? cityName;
  double? ratingAverage;
  int? levelId;
  int? numberRating;


  RatingModel.fromJson(Map<String, dynamic> json) {
    userId = json["UserID"];
    fullName = json["FullName"];
    imagePath = json["ImagePath"];
    ratingAverage = json["RatingAverage"];
    levelId = json["LevelID"];
    numberRating = json["NumberRating"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["UserID"] = userId;
    _data["FullName"] = fullName;
    _data["ImagePath"] = imagePath;
    _data["RatingAverage"] = ratingAverage;
    _data["LevelID"] = levelId;
    _data["NumberRating"] = numberRating;
    return _data;
  }

  static ResponseBase<List<RatingModel>>? getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <RatingModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(RatingModel.fromJson(v));
        });
      }
      return ResponseBase<List<RatingModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
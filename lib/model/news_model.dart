
import 'base_response.dart';

class NewsModel {
  int? newsId;
  String? title;
  String? imagePath;
  String? shortDecription;
  String? description;

  NewsModel.fromJson(Map<String, dynamic> json) {
    newsId = json["NewsID"];
    title = json["Title"];
    imagePath = json["ImagePath"];
    shortDecription = json["ShortDecription"];
    description = json["Description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["NewsID"] = newsId;
    _data["Title"] = title;
    _data["ImagePath"] = imagePath;
    _data["ShortDecription"] = shortDecription;
    _data["Description"] = description;
    return _data;
  }


  static ResponseBase<List<NewsModel>>? getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <NewsModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(NewsModel.fromJson(v));
        });
      }
      return ResponseBase<List<NewsModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}
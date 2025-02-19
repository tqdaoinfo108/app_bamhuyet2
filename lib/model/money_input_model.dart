import 'package:intl/intl.dart';

import 'base_response.dart';

class MoneyInputModel {
  int? moneyInputId;
  String? dateInput;
  int? userId;
  double? amount;
  bool? isActive;

  String get getAmount =>
      NumberFormat.decimalPattern('vi').format(amount ?? 0) + "đ";

  MoneyInputModel.fromJson(Map<String, dynamic> json) {
    moneyInputId = json["MoneyInputID"];
    dateInput = json["DateInput"];
    userId = json["UserID"];
    amount = json["Amount"];
    isActive = json["IsActive"];
  }


  static ResponseBase<List<MoneyInputModel>>? getFromJson(Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <MoneyInputModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(MoneyInputModel.fromJson(v));
        });
      }
      return ResponseBase<List<MoneyInputModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["MoneyInputID"] = moneyInputId;
    _data["DateInput"] = dateInput;
    _data["UserID"] = userId;
    _data["Amount"] = amount;
    _data["IsActive"] = isActive;
    return _data;
  }
}
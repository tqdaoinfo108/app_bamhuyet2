import 'package:intl/intl.dart';

import 'base_response.dart';

class BookingModel {
  int? bookingId;
  String? bookingCode;
  int? typeBookingId;
  int? userIdBooking;
  int? userAddressId;
  int? userIdProccess;
  int? serviceId;
  String? minute;
  double? amount;
  double? amountDiscount;
  String? bookingDate;
  DateTime? dateStart;
  int? statusId;
  int? statusPayment;
  dynamic datePayment;
  String? serviceName;
  String? bookingCustomerAddress;

  String? branchName;
  String? branchAddress;
  String? branchPhone;

  BookingModel();

  // bool get isAvaialbe => 

  String get getAmount =>
      NumberFormat.decimalPattern('vi').format(amount) + "đ";
  String get getMinute => "$minute";

  Duration getDurationDown(dateTime) {
    DateTime now = DateTime.now();
    Duration difference = dateStart!.difference(now);
    return difference;
  }

  bool isValidDuration(DateTime now) {
    Duration difference = now.difference(dateStart!);
    if (difference.inMinutes <= 0 && statusId == 0) {
      return true; 
    }
    return false;
  }

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingId = json["BookingID"];
    bookingCode = json["BookingCode"];
    typeBookingId = json["TypeBookingID"];
    userIdBooking = json["UserID_Booking"];
    userAddressId = json["UserAddressID"];
    userIdProccess = json["UserID_Proccess"];
    serviceId = json["ServiceID"];
    minute = json["Minute"];
    amount = json["Amount"];
    amountDiscount = json["AmountDiscount"];
    bookingDate = json["BookingDate"];
    dateStart = DateTime.tryParse(json["DateStart"]);
    statusId = json["StatusID"];
    statusPayment = json["StatusPayment"];
    datePayment = json["DatePayment"];
    serviceName = json["ServiceName"];
    bookingCustomerAddress = json["BookingCustomerAddress"];
    branchName = json['BranchName'];
    branchAddress = json['BranchAddress'];
    branchPhone = json['BranchPhone'];
  }

  static ResponseBase<List<BookingModel>>? getFromJsonList(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <BookingModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(BookingModel.fromJson(v));
        });
      }
      return ResponseBase<List<BookingModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      int status = json["status"] ?? 0;
      return ResponseBase(status: status);
    }
  }

  static ResponseBase<BookingModel> getFromJsonObject(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      return ResponseBase<BookingModel>(
        data: BookingModel.fromJson(json['data']),
      );
    } else {
      return ResponseBase();
    }
  }
}

import 'base_response.dart';

class HistoryModel {
  int? bookingID;
  String? bookingCode;
  int? typeBookingID;
  int? userIDBooking;
  int? userAddressID;
  int? userIDProccess;
  Null? branchIDProccess;
  int? serviceID;
  int? minute;
  double? amount;
  // int? amountDiscount;
  String? bookingDate;
  String? dateStart;
  int? statusID;
  int? statusPayment;
  Null? datePayment;
  String? description;
  String? dateCreated;
  String? dateUpdated;
  String? serviceName;
  String? fullName;
  String? userName;
  bool? genderID;
  String? genderName;
  String? address;
  double? ingUser;
  double? latUser;
  String? countryName;
  String? fullNameProcess;
  String? userNameProcess;
  String? branchName;
  String? branchAddress;
  String? branchPhone;
  String? bookingCustomerFullName;
  String? bookingCustomerAddress;
  String? bookingCustomerPhone;

  HistoryModel(
      {this.bookingID,
      this.bookingCode,
      this.typeBookingID,
      this.userIDBooking,
      this.userAddressID,
      this.userIDProccess,
      this.branchIDProccess,
      this.serviceID,
      this.minute,
      this.amount,
      // this.amountDiscount,
      this.bookingDate,
      this.dateStart,
      this.statusID,
      this.statusPayment,
      this.datePayment,
      this.description,
      this.dateCreated,
      this.dateUpdated,
      this.serviceName,
      this.fullName,
      this.userName,
      this.genderID,
      this.genderName,
      this.address,
      this.ingUser,
      this.latUser,
      this.countryName,
      this.fullNameProcess,
      this.userNameProcess,
      this.branchName,
      this.branchAddress,
      this.branchPhone,
      this.bookingCustomerFullName,
      this.bookingCustomerAddress,
      this.bookingCustomerPhone});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    bookingID = json['BookingID'];
    bookingCode = json['BookingCode'];
    typeBookingID = json['TypeBookingID'];
    userIDBooking = json['UserID_Booking'];
    userAddressID = json['UserAddressID'];
    userIDProccess = json['UserID_Proccess'];
    branchIDProccess = json['BranchID_Proccess'];
    serviceID = json['ServiceID'];
    minute = json['Minute'];
    amount = json['Amount'];
    // amountDiscount = json['AmountDiscount'];
    bookingDate = json['BookingDate'];
    dateStart = json['DateStart'];
    statusID = json['StatusID'];
    statusPayment = json['StatusPayment'];
    datePayment = json['DatePayment'];
    description = json['Description'];
    dateCreated = json['DateCreated'];
    dateUpdated = json['DateUpdated'];
    serviceName = json['ServiceName'];
    fullName = json['FullName'];
    userName = json['UserName'];
    genderID = json['GenderID'];
    genderName = json['GenderName'];
    address = json['Address'];
    ingUser = json['IngUser'];
    latUser = json['LatUser'];
    countryName = json['CountryName'];
    fullNameProcess = json['FullName_process'];
    userNameProcess = json['UserName_process'];
    branchName = json['BranchName'];
    branchAddress = json['BranchAddress'];
    branchPhone = json['BranchPhone'];
    bookingCustomerFullName = json['BookingCustomerFullName'];
    bookingCustomerAddress = json['BookingCustomerAddress'];
    bookingCustomerPhone = json['BookingCustomerPhone'];
  }

  static ResponseBase<List<HistoryModel>>? getFromJson(
      Map<String, dynamic> json) {
    if (json["message"] == null) {
      var list = <HistoryModel>[];
      if (json['data'] != null) {
        json['data'].forEach((v) {
          list.add(HistoryModel.fromJson(v));
        });
      }
      return ResponseBase<List<HistoryModel>>(
        totals: json['totals'] ?? json['total'],
        data: list,
      );
    } else {
      return ResponseBase();
    }
  }
}

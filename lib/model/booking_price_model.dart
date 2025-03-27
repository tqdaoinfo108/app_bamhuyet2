class PriceBooking {
  double? amounBooking;
  double? percentCommission;
  double? amountCommission;
  double? amountAfterCommission;
  double? amountCurrent;

  PriceBooking(
      {this.amounBooking,
        this.percentCommission,
        this.amountCommission,
        this.amountAfterCommission,
        this.amountCurrent});

  PriceBooking.fromJson(Map<String, dynamic> json) {
    amounBooking = json['AmounBooking'];
    percentCommission = json['PercentCommission'];
    amountCommission = json['AmountCommission'];
    amountAfterCommission = json['AmountAfterCommission'];
    amountCurrent = json['AmountCurrent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AmounBooking'] = this.amounBooking;
    data['PercentCommission'] = this.percentCommission;
    data['AmountCommission'] = this.amountCommission;
    data['AmountAfterCommission'] = this.amountAfterCommission;
    data['AmountCurrent'] = this.amountCurrent;
    return data;
  }
}
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../../model/booking_price_model.dart';
import '../../../model/history_model.dart';
import '../../../services/app_services.dart';
import '../../../utils/constants.dart';

class HistoryHotelCard extends StatefulWidget {
  const HistoryHotelCard(this.data, {super.key});
  final HistoryModel data;

  @override
  State<HistoryHotelCard> createState() => _HistoryHotelCardState();
}

class _HistoryHotelCardState extends State<HistoryHotelCard> {
  late PriceBooking? priceBooking;
  bool isLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    processApplyJob();
  }
  processApplyJob() async {
    setState(() {
      isLoad = true;
    });
    var rs = await AppServices.instance.postGetPrice(widget.data.bookingID!);
    if (rs != null) {
      setState(() {
        priceBooking = rs;
      });
    } else {
    }
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadious)),
        color: lightGreyColor,
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("code".trans()),
            Text(widget.data.bookingCode ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("start_time".trans()),
            Text(widget.data.getDateStart,
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("name".trans()),
            Text(widget.data.bookingCustomerFullName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("phone".trans()),
            Text(widget.data.bookingCustomerPhone ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [
            Text("address".trans()),
            Flexible(
              child: Text(widget.data.bookingCustomerAddress ?? "",textAlign:
              TextAlign.end,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("price".trans()),
            Text(widget.data.getAmount, style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("amountAfterCommission".trans()),
            Text(isLoad ? "" : priceBooking!.getAmount, style: TextStyle
              (fontWeight:
            FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("note".trans()),
            Text(widget.data.description ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("status".trans()),
            Text(
              widget.data.statusID == 1
                  ? "finish".trans()
                  : [-1, -2].contains(widget.data.statusID)
                      ? "cancel".trans()
                      : widget.data.statusID == 0
                          ? "in_progress".trans()
                          : "waiting".trans(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    );
  }
}

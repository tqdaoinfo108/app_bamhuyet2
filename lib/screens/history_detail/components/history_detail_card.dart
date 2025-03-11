import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../../model/history_model.dart';
import '../../../utils/constants.dart';

class HistoryHotelCard extends StatelessWidget {
  const HistoryHotelCard(this.data, {super.key});
  final HistoryModel data;

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
            Text(data.bookingCode ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("start_time".trans()),
            Text(data.getDateStart,
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("name".trans()),
            Text(data.bookingCustomerFullName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("phone".trans()),
            Text(data.bookingCustomerPhone ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("address".trans()),
            Text(data.bookingCustomerAddress ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("price".trans()),
            Text(data.getAmount, style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("note".trans()),
            Text(data.description ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("status".trans()),
            Text(
              data.statusID == 1
                  ? "finish".trans()
                  : [-1, -2].contains(data.statusID)
                      ? "cancel".trans()
                      : data.statusID == 0
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

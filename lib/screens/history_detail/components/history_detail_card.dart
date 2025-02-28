import 'package:flutter/material.dart';

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
            Text("Mã"),
            Text(data.bookingCode ?? "",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Giờ bắt đầu"),
            Text(data.getDateStart,
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Tên"),
            Text(data.bookingCustomerFullName ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Điện thoại"),
            Text(data.bookingCustomerPhone ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Địa chỉ"),
            Text(data.bookingCustomerAddress ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Giá"),
            Text(data.getAmount, style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Ghi chú"),
            Text(data.description ?? "",
                style: TextStyle(fontWeight: FontWeight.bold))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Trạng thái"),
            Text(
              data.statusID == 1
                  ? "Hoàn thành"
                  : [-1, -2].contains(data.statusID)
                      ? "Hủy"
                      : data.statusID == 0
                          ? "Đang thực hiện"
                          : "Chờ xử lý",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
        ],
      ),
    );
  }
}

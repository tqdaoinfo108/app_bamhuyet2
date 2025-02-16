import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constants.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(this.data, {super.key});
  final HistoryModel data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        SnackbarHelper.showSnackBar(
            "Đang phát triển", ToastificationType.success);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.titleHeight,
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(0),
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(defaultBorderRadious),
                    topLeft: Radius.circular(defaultBorderRadious),
                  ),
                  color: lightGreyColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/info.svg", height: 20),
                        SizedBox(width: 4),
                        Text(data.bookingCode ?? "",
                            style: TextStyle(fontSize: 14))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/Clock.svg", height: 20),
                        SizedBox(width: 4),
                        Text(data.getDateStart, style: TextStyle(fontSize: 14))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/Address.svg",
                            height: 20),
                        SizedBox(width: 4),
                        Flexible(
                            child: Text(data.bookingCustomerAddress ?? "",
                                style: TextStyle(fontSize: 14)))
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text("Bấm để xem chi tiết",
                            style: TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey.shade400)),
                        SizedBox(width: 4),
                        SvgPicture.asset(
                          "assets/icons/Send.svg",
                          height: 14,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  if (data.statusID == 0)
                    InkWell(
                      onTap: () async {
                        await launchUrl(Uri(scheme: 'tel', path: data.bookingCustomerPhone!));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(defaultBorderRadious),
                          ),
                          color: Colors.lightBlue,
                        ),
                        height: 48,
                        width: 48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.white,
                            ),
                            Text(
                              "Gọi",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(defaultBorderRadious),
                          bottomLeft: Radius.circular(
                              ![0,2].contains(data.statusID)
                                  ? defaultBorderRadious
                                  : 0),
                        ),
                        color: data.statusID == 1
                            ? Colors.lightGreen
                            : [-1, -2].contains(data.statusID)
                                ? Colors.redAccent
                                : data.statusID == 0
                                    ? Colors.lightBlueAccent
                                    : Colors.grey,
                      ),
                      height: 48, // Chiều cao cố định
                      width: 48,
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/icons/Doublecheck.svg",
                            height: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            data.statusID == 1
                                ? "Hoàn thành"
                                : [-1, -2].contains(data.statusID)
                                    ? "Hủy"
                                    : data.statusID == 0
                                        ? "Đang thực hiện"
                                        : "Chờ xử lý",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

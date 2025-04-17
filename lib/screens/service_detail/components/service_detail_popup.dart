import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../../model/service_model.dart';

class ServiceDetailPopup extends StatefulWidget {
  const ServiceDetailPopup(this.lstServiceDetails, this.onPressed, {super.key});
  final List<LstServiceDetails> lstServiceDetails;
  final Function() onPressed;
  @override
  State<ServiceDetailPopup> createState() => _ServiceDetailPopupState();
}

class _ServiceDetailPopupState extends State<ServiceDetailPopup> {
  String amount = "";

  @override
  void initState() {
    super.initState();
    widget.lstServiceDetails.forEach((item) => item.isChoose = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBar(
            title: Text("choose_time".trans()),
          ),
          SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              children: widget.lstServiceDetails.map((e) {
                return IntrinsicWidth(
                  child: OutlinedButton(
                      onPressed: () {
                        widget.lstServiceDetails
                            .forEach((item) => item.isChoose = false);
                        setState(() {
                          e.isChoose = true;
                          amount = NumberFormat.decimalPattern('vi')
                              .format(e.amount);
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              e.isChoose ? greyColor.withOpacity(.6) : null,
                          padding: const EdgeInsets.all(8)),
                      child: Text(
                        "${e.minute}",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      )),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: ElevatedButton(
              onPressed: widget.onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("continue".trans()),
                  if (amount != "") Text("$amount vnd")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

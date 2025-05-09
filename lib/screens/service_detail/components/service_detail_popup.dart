import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/service_model.dart';

class ServiceDetailPopup extends StatefulWidget {
  const ServiceDetailPopup(
      this.typeID, this.lstServiceDetails, this.onPressed, this.phoneContact,
      {super.key});
  final List<LstServiceDetails> lstServiceDetails;
  final Function() onPressed;
  final int typeID;
  final String? phoneContact;
  @override
  State<ServiceDetailPopup> createState() => _ServiceDetailPopupState();
}

class _ServiceDetailPopupState extends State<ServiceDetailPopup> {
  String amount = "";
  String description = "";
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
                          description = e.description ?? "";
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
          Container(
            alignment: Alignment.topLeft,
            constraints: BoxConstraints(maxHeight: 150),
            child: SingleChildScrollView(child: Text(description)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: widget.typeID == 3
                      ? () async {
                          await launchUrl(
                              Uri(scheme: 'tel', path: widget.phoneContact));
                        }
                      : widget.onPressed,
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.blueAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "continue".trans(),
                        style: widget.typeID == 3
                            ? Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white)
                            : null,
                      ),
                      amount != ""
                          ? Text(
                              "$amount vnd",
                              style: widget.typeID == 3
                                  ? Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.white)
                                  : null,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                if (widget.phoneContact != '')
                  ElevatedButton(
                    style:
                        Theme.of(context).elevatedButtonTheme.style?.copyWith(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              // other properties
                            ),
                    onPressed: () async {
                      await launchUrl(
                          Uri(scheme: 'tel', path: widget.phoneContact));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('support'.trans() + ": " + widget.phoneContact!)
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

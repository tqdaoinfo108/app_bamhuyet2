import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../components/app_snackbar.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../model/service_branch_partner.dart';
import '../../../services/app_services.dart';
import '../../../utils/constants.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem(this.data, this.isPartner, {super.key});
  final ServiceModel data;
  final ServiceBranchPartner isPartner;
  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: defaultPadding / 2, horizontal: defaultPadding),
      decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(defaultBorderRadious)),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(
                  left: defaultPadding, right: defaultPadding),
              decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadious)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  widget.data.serviceName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: Checkbox(
                    value: widget.data.isExpand,
                    onChanged: (evv) {
                      setState(() {
                        widget.data.isExpand = evv ?? false;
                      });
                    },
                    activeColor: primaryColor),
              )),
          if (widget.data.isExpand)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    final _picker = HLImagePicker();

                    final images = await _picker.openPicker();
                    var response = await AppServices.instance
                        .uploadFile(images.first.path);
                    if (response != null) {
                      SnackbarHelper.showSnackBar(
                          "success".trans(), ToastificationType.success);
                      setState(() {
                        widget.data.imagePath = response.data!;
                      });
                    } else {
                      SnackbarHelper.showSnackBar(
                          "cancel".trans(), ToastificationType.warning);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 68,
                        height: 68,
                        child: NetworkImageWithLoader(
                          widget.data.imagePath,
                        ),
                      ),
                      Icon(Icons.change_circle_rounded)
                    ],
                  ),
                ),
                Column(
                    children: widget.data.lstServiceDetails.map((z) {
                  return Container(
                    margin: const EdgeInsets.only(left: defaultPadding, top: 4),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        border: Border.all(color: Colors.black12)),
                    child: ListTile(
                      title: widget.isPartner.branchID != 0
                          ? TextField(
                              controller:
                                  TextEditingController(text: "${z.minute}"),
                              onChanged: (value) => z.minute = value,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabled: widget.isPartner.partnerID == 0,
                                hintStyle: TextStyle(fontSize: 14),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.all(4),
                              ))
                          : Text(
                              "${z.minute!}".trans(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: purpleColor),
                            ),
                      trailing: SizedBox(
                        width: 120,
                        child: TextField(
                          controller: TextEditingController(
                              text: "${z.amountFormatString}"),
                          onChanged: (value) => z.amount = (double.tryParse(
                                  value
                                      .replaceAll('đ', '')
                                      .replaceAll('.', '')) ??
                              0),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabled: widget.isPartner.partnerID == 0,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: 'price'.trans(),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.all(4),
                          ),
                          // ), OutlineInputBorder(
                          //       labelStyle: TextStyle(),
                          //       enabled: widget.isPartner.branchID != 0,
                          //       hintStyle: TextStyle(color: Colors.grey),
                          //       suffix: Text("đ")),
                        ),
                      ),
                    ),
                  );
                }).toList()),
              ],
            )
        ],
      ),
    );
  }
}

import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:flutter/material.dart';

import '../../../model/service_branch_partner.dart';
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
            )
          ),
          if (widget.data.isExpand)
            Column(
                children: widget.data.lstServiceDetails.map((z) {
              return Container(
                margin: const EdgeInsets.only(left: defaultPadding, top: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadious),
                    border: Border.all(color: Colors.black12)),
                child: ListTile(
                  title: Text("${z.minute!} phút",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: purpleColor),
                  ),
                  trailing: SizedBox(
                    width: 120,
                    child: TextField(
                      controller: TextEditingController(text: "${z.amountFormatString}"),
                      onChanged: (value) => z.amount = (double.tryParse(value.replaceAll('đ', '').replaceAll('.', '')) ?? 0) ,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabled: widget.isPartner.partnerID == 0,
                        hintStyle: TextStyle(fontSize: 14),
                        hintText: 'Giá',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder:UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ) ,
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
            }).toList())
        ],
      ),
    );
  }
}

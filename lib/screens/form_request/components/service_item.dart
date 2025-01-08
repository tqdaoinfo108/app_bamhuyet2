import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem(this.data, {super.key});
  final ServiceModel data;
  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
       decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadious)),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 3),
            decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadious)),
            child: Row(
              children: [
                Text(
                  widget.data.serviceName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Checkbox(
                    value: widget.data.isExpand,
                    onChanged: (evv) {
                      setState(() {
                        widget.data.isExpand = evv ?? false;
                      });
                    },
                    activeColor: primaryColor)
              ],
            ),
          ),
          if (widget.data.isExpand)
            Column(children: widget.data.lstServiceDetails.map((z){
              return Container(
              margin: const EdgeInsets.only(left: defaultPadding, top: 4),
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadious),border: Border.all(color: Colors.black12)),
              child: Row(
                children: [
                  Text(
                    z.description!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: purpleColor),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 160,
                    child: TextField(
                      controller: TextEditingController(text: "${z.amount}"),
                      onChanged: (value) => z.amount = (double.tryParse(value) ?? 0),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            );
            }).toList())
        ],
      ),
    );
  }
}

import 'package:app_bamnguyet_2/components/custom_modal_bottom_sheet.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/address_model.dart';
import 'package:app_bamnguyet_2/screens/address/components/address_item.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';

import 'components/address_form.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, this.modeChoose = false});

  final bool? modeChoose;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<AddressModel> list = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    onLoading();
  }

  onLoading() async {
    try {
      setState(() {
        isLoading = true;
        list = [];
      });
      var address = await AppServices.instance.getListAddress();
      if (address != null) {
        setState(() {
          list = address.data ?? [];
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Địa chỉ"),
        actions: [
          InkWell(
              onTap: () async {
                await customModalBottomSheet(context,
                    child: AddressForm(), isDismissible: false);
                await onLoading();
              },
              child: Text(
                "Tạo mới",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
          SizedBox(width: defaultPadding)
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return AddressItem(list[index], () async {
                      if (widget.modeChoose ?? false) {
                        Navigator.pop(context, list[index]);
                        return;
                      }

                      await customModalBottomSheet(context,
                          child: AddressForm(dataInit: list[index]),
                          isDismissible: false);

                      await onLoading();
                    });
                  },
                  itemCount: list.length,
                )
              ],
            ),
    );
  }
}

import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/money_input_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../../components/custom_modal_bottom_sheet.dart';
import 'components/wallet_popup.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<MoneyInputModel> list = [];
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
      });
      var address = await AppServices.instance.getListMoneyInput();
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
          title: Text("wallet".trans()),
          actions: [IconButton(onPressed: () async {
            await customModalBottomSheet(context, child: WalletPopup());
            await onLoading();
          }, icon: Icon(Icons.add))],
        ),
        body: isLoading
            ? loadingWidget()
            : list.isEmpty
                ? Center(
                    child: Text("no_data".trans()),
                  )
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (c, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "submit".trans()+" ${list[i].getAmount}",
                                  style: AppTheme.getTextStyle(context,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('HH:mm dd-MM-yyyy').format(
                                          DateTime.parse(list[i].dateInput!)),
                                      style: AppTheme.getTextStyle(context,
                                              fontSize: 12)
                                          .copyWith(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      list[i].isActive! ? "finish".trans() : "wating_for_accept".trans(),
                                      style: AppTheme.getTextStyle(context,
                                          fontSize: 12)
                                          .copyWith(color: list[i].isActive! ? Colors.green : Colors.blue),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
  }
}

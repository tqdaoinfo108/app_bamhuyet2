import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

class WalletPopup extends StatefulWidget {
  const WalletPopup({super.key});

  @override
  State<WalletPopup> createState() => _WalletPopupState();
}

class _WalletPopupState extends State<WalletPopup> {
  final inputMoneyController = TextEditingController();
  String value = "0";

  onCreateMoney() async {
    var rs =
        await AppServices.instance.postCreateMoneyInput(double.parse(value));
    if (rs) {
      SnackbarHelper.showSnackBar("success", ToastificationType.success);
      Navigator.of(context).pop();
    } else {
      SnackbarHelper.showSnackBar("error", ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTextField(
                  inputMoneyController,
                  "enter_money".trans(),
                  "enter_money".trans(),
                  onChanged: (s) {
                    setState(() {
                      if (s == '') s = "0";
                      value = s ?? "0";
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(NumberFormat.decimalPattern('vi')
                          .format(double.parse(value)) +
                      "đ"),
                ),
                Image.asset("assets/images/qr.jpg"),
                Text("STK: 0783828999", style: AppTheme.getTextStyle(context,
                    fontWeight: FontWeight.bold, fontSize: 16)),
                Text("NAM A BANK - DAO NGOC BANG", style: AppTheme.getTextStyle(context,
                    fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await onCreateMoney();
                  },
                  child: Text("send".trans()),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

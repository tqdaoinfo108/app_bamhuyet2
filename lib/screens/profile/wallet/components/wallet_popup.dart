import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    if (rs ) {
      SnackbarHelper.showSnackBar(
          "Thành công", ToastificationType.success);
      Navigator.of(context).pop();
    } else {
      SnackbarHelper.showSnackBar(
          "Thao tác thất bại", ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Nộp tiền vào ví"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                inputMoneyController,
                "Nhập số tiền",
                "Nhập số tiền",
                onChanged: (s) {
                  setState(() {
                    if (s == '') s = "0";
                    value = s ?? "0";
                  });
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(NumberFormat.decimalPattern('vi')
                        .format(double.parse(value)) +
                    "đ"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await onCreateMoney();
                },
                child: const Text("Gửi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

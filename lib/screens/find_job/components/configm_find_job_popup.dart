import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/booking_price_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../model/booking_model.dart';
import '../../../route/route_constants.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/constants.dart';

class ConfirmFindJobPopup extends StatefulWidget {
  const ConfirmFindJobPopup(this.data, this.onApplyJob, {super.key});

  final BookingModel data;
  final Function() onApplyJob;
  @override
  State<ConfirmFindJobPopup> createState() => _ConfirmFindJobPopupState();
}

class _ConfirmFindJobPopupState extends State<ConfirmFindJobPopup> {
  var isApplyJob = false;
  late PriceBooking price;
  bool isLoading  = false;
  @override
  void initState() {
    super.initState();
    processApplyJob();
  }

  processApplyJob() async {
    setState(() {
      isLoading = true;
    });
    PriceBooking? rs =
        await AppServices.instance.postGetPrice(widget.data.bookingId!);
    if (rs != null) {
      setState(() {
        isApplyJob = rs.amountAfterCommission! <= rs.amountCurrent!;
      });
      price = rs;
    } else {
      SnackbarHelper.showSnackBar("error".trans(), ToastificationType.error);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  isLoading ? loadingWidget() : IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/apply_job.png",
              width: 80,
            ),
            Text("apply".trans(),
                style: AppTheme.getTextStyle(context,
                    fontWeight: FontWeight.bold, fontSize: 18)),
            Text("${'address'.trans()}: ${widget.data.bookingCustomerAddress}",
                style: AppTheme.getTextStyle(context, fontSize: 14)),
            if (!isApplyJob)
              Text("${'note_apply_job'.trans(arguments: {"price": "${ price
                  .getPrice}"})}",
                  style: AppTheme.getTextStyle(context, fontSize: 13).copyWith(
                      fontStyle: FontStyle.italic, color: primaryColor)),
            if (isApplyJob)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(defaultBorderRadious * 2),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                onPressed: () {
                  widget.onApplyJob();
                },
                child: Text("apply".trans()),
              ),
            if (!isApplyJob)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(defaultBorderRadious * 2),
                  ),
                  padding: EdgeInsets.all(5),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, walletScreen);
                },
                child: Text("wallet".trans()),
              )
          ],
        ),
      ),
    );
  }
}

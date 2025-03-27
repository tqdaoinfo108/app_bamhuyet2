import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/model/booking_price_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../model/booking_model.dart';
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
  @override
  void initState() {
    super.initState();
  }

  processApplyJob() async {
    PriceBooking? rs =
        await AppServices.instance.postGetPrice(widget.data.bookingId!);
    if (rs != null) {
      setState(() {
        isApplyJob = rs.amountAfterCommission! <= rs.amountCurrent!;
      });
    } else {
      SnackbarHelper.showSnackBar("error".trans(), ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            if(isApplyJob)
              Flexible(
                child: ElevatedButton(
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
              ),

            if(!isApplyJob)
              Flexible(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(defaultBorderRadious * 2),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  onPressed: () {
                    widget.onApplyJob();
                  },
                  child: Text("wallet".trans()),
                ),
              )
          ],
        ),
      ),
    ));
  }
}

import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:toastification/toastification.dart';
import '../../../components/app_snackbar.dart';
import '../../../model/booking_model.dart';

class FindJobCard extends StatelessWidget {
  const FindJobCard(this.data, this.onBooking, {super.key});
  final BookingModel data;
  final Function() onBooking;
  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: OutlinedButton(
        onPressed: () {
          if (!data.isValidDuration(dateTime)) {
            SnackbarHelper.showSnackBar(
                "expired_message".trans(), ToastificationType.warning);
          }
        },
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor:
                !data.isValidDuration(dateTime) || data.statusId != 0 ?
                Colors.grey.shade300 : null),
        child: Column(
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 7,
                  child: Text(data.serviceName ?? "",
                      style: AppTheme.getTextStyle(context,
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Flexible(
                  flex: 3,
                  child: Text(data.getMinute,
                      style: AppTheme.getTextStyle(context, fontSize: 14)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "new_job".trans(),
                      style: AppTheme.getTextStyle(context, fontSize: 14),
                    ),
                    SizedBox(width: 5),
                    data.statusId! == 2 ? Text("in_progress".trans() ):
                     data.isValidDuration(dateTime)
                        ? SlideCountdown(
                            duration: data.getDurationDown(dateTime),
                            shouldShowDays: (duration) => duration.inDays != 0,
                            shouldShowHours: (duration) => duration.inHours != 0,
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                          )
                        : Text("expired".trans())
                  ],
                ),
                Text(
                  data.getAmount,
                  style: AppTheme.getTextStyle(context,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/Clock.svg", height: 20),
                SizedBox(width: 4),
                Text(
                  "working_time".trans() +
                      ": ${DateFormat('HH:mm dd-MM-yyyy').format(data.dateStart!)}",
                  style: TextStyle(fontSize: 14, color: primaryColor),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/Profile.svg",
                    height: 20, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  "Male_customer_HCM".trans(),
                  style: AppTheme.getTextStyle(context, fontSize: 14),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/Location.svg",
                    height: 20, color: Colors.black),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    data.bookingCustomerAddress ?? "",
                    style: AppTheme.getTextStyle(context, fontSize: 14),
                  ),
                )
              ],
            ),
            if(data.branchName != '')
            Row(
              children: [
                SvgPicture.asset("assets/icons/Location.svg",
                    height: 20, color: Colors.black),
                SizedBox(width: 4),
                Flexible(
                  child: Text("${'branch'.trans()} ${data.branchName}",
                    style: AppTheme.getTextStyle(context, fontSize: 14),
                  ),
                )
              ],
            ),
            if (data.isValidDuration(dateTime) && data.statusId! == 0)
              Row(
                children: [
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
                        if (GetStorage().read(userTypeUser) != 2) {
                          SnackbarHelper.showSnackBar(
                              "you_are_not_collaborator".trans(),
                              ToastificationType.warning);
                          return;
                        }
                        onBooking();
                      },
                      child: Text("apply".trans()),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

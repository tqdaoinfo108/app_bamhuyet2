import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:toastification/toastification.dart';
import '../../../components/app_snackbar.dart';
import '../../../model/booking_model.dart';

class FindJobCard extends StatelessWidget {
  const FindJobCard(this.data, this.dateTime, {super.key});
  final BookingModel data;
  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: OutlinedButton(
        onPressed: () {
          if (!data.isValidDuration(dateTime)) {
            SnackbarHelper.showSnackBar(
                "Tin đã quá hạn !", ToastificationType.warning);
          }
        },
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor:
                !data.isValidDuration(dateTime) ? Colors.grey.shade300 : null),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.serviceName ?? "",
                    style: AppTheme.getTextStyle(context,
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text(data.getMinute,
                    style: AppTheme.getTextStyle(context, fontSize: 14))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Việc mới",
                      style: AppTheme.getTextStyle(context, fontSize: 14),
                    ),
                    SizedBox(width: 5),
                    data.isValidDuration(dateTime)
                        ? SlideCountdownSeparated(
                            duration: data.getDurationDown(dateTime),
                            shouldShowDays: (duration) => duration.inDays == 0,
                            
                            padding: const EdgeInsets.all(3),
                          )
                        : Text("Đã quá hạn")
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
                  "Giờ làm việc: ${DateFormat('HH:mm dd-MM-yyyy').format(data.dateStart!)}",
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
                  "Khách Nam, Hồ Chí Minh",
                  style: AppTheme.getTextStyle(context, fontSize: 14),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset("assets/icons/Location.svg",
                    height: 20, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  data.bookingCustomerAddress ?? "",
                  style: AppTheme.getTextStyle(context, fontSize: 14),
                )
              ],
            ),
            if (data.isValidDuration(dateTime))
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(.3),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadious * 2),
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                      onPressed: () {},
                      child: const Text("Chi Tiết"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadious * 2),
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                      onPressed: () {},
                      child: const Text("Ứng tuyển"),
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

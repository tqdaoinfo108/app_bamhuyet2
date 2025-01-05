import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/button_theme.dart';

class FindJobCard extends StatelessWidget {
  const FindJobCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Massage đầu",
                    style: AppTheme.getTextStyle(context, fontSize: 14)),
                Text("90 phút",
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
                  ],
                ),
                Text(
                  "400.000d",
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
                  "Giờ làm việc: Cần ngay 2/1",
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
                  "Phường 15, Quận 11, Hồ Chi Minh",
                  style: AppTheme.getTextStyle(context, fontSize: 14),
                )
              ],
            ),
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

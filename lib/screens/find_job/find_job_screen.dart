import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:weekly_calendar/weekly_calendar.dart';

import 'components/find_job_card.dart';

class FindJobScreen extends StatelessWidget {
  const FindJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WeeklyCalendar(
            calendarStyle: CalendarStyle(
              locale: "vi",
              isShowFooterDateText: false,
              isShowHeaderDateText: false,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              selectedCircleColor: primaryColor,
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return FindJobCard();
                  },
                  itemCount: 1,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

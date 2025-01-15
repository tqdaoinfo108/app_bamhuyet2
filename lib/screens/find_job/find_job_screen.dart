import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:weekly_calendar/weekly_calendar.dart';

import '../../model/booking_model.dart';
import 'components/find_job_card.dart';

class FindJobScreen extends StatefulWidget {
  const FindJobScreen({super.key});

  @override
  State<FindJobScreen> createState() => _FindJobScreenState();
}

class _FindJobScreenState extends State<FindJobScreen> {
  DateTime dateTime = DateTime.now();
  List<BookingModel> list = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      loadList();
    }
  }

  loadList() async {
    var respose = await AppServices.instance
        .getListBooking(lat: 0, lng: 0, dateTime: dateTime, page: 1);
    setState(() {
      list = respose?.data ?? [];
    });
  }

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
            flex: 10,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return FindJobCard(list[index],dateTime);
              },
              itemCount: list.length,
            ),
          )
        ],
      ),
    );
  }
}

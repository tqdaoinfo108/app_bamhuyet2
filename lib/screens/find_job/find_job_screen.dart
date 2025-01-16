import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:weekly_calendar/weekly_calendar.dart';

import '../../components/app_snackbar.dart';
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
  bool isLoading = false;

  onBooking(int bookingID) async {
    var response = await AppServices.instance
        .postPartnerReciveBooking(bookingID: bookingID);
    if (response != null) {
      SnackbarHelper.showSnackBar(
          "Ứng tuyển thành công", ToastificationType.error);
    } else {
      SnackbarHelper.showSnackBar("Thất bại", ToastificationType.error);
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      loadList(dateTime);
    }
  }

  loadList(DateTime dateTime) async {
    setState(() {
      isLoading = true;
    });
    var respose = await AppServices.instance
        .getListBooking(lat: 0, lng: 0, dateTime: dateTime, page: 1);
    setState(() {
      list = respose?.data ?? [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          WeeklyCalendar(
            onChangedSelectedDate: (p0) async {
              await loadList(p0);
            },
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
            child: isLoading
                ? loadingWidget()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return FindJobCard(list[index], dateTime);
                    },
                    itemCount: list.length,
                  ),
          )
        ],
      ),
    );
  }
}

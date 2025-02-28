import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_snackbar.dart';
import '../../components/loading.dart';
import '../../model/history_model.dart';
import 'components/history_detail_card.dart';

class HistoryHotelScreen extends StatefulWidget {
  const HistoryHotelScreen({required this.data, super.key});
  final HistoryModel data;
  @override
  State<HistoryHotelScreen> createState() => _HistoryHotelScreenState();
}

class _HistoryHotelScreenState extends State<HistoryHotelScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết"),
      ),
      body: isLoading
          ? loadingWidget()
          : SingleChildScrollView(
              child: Column(
                spacing: 20,
                children: [
                  HistoryHotelCard(widget.data),
                  if (widget.data.statusID == 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          var rs = await AppServices.instance
                              .postFinalBooking(widget.data.bookingID!);
                          if (rs) {
                            SnackbarHelper.showSnackBar("Thao tác thành công",
                                ToastificationType.success);
                            Navigator.of(context).pop(true);
                          } else {
                            SnackbarHelper.showSnackBar(
                                "Thao tác thất bại", ToastificationType.error);
                          }
                        },
                        child: const Text("Hoàn thành"),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

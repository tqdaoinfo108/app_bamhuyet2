import 'package:app_bamnguyet_2/model/base_response.dart';
import 'package:app_bamnguyet_2/model/history_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../components/loading.dart';
import '../../route/route_constants.dart';
import 'components/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isLoading = false;
  List<HistoryModel> listData = [];
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    isLoading = true;
    ResponseBase<List<HistoryModel>>? response =
        await AppServices.instance.getHistory();
    if (response != null) {
      listData = response.data ?? [];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("activity_history".trans()),
      ),
      body: SafeArea(
          child: isLoading
              ? loadingWidget()
              : listData.isEmpty
                  ? Center(
                      child: Text("no_data".trans()),
                    )
                  : ListView.builder(
                      itemBuilder: (c, i) {
                        return HistoryCard(listData[i], () async {
                          var result = await Navigator.pushNamed(
                              context, historydetailscreen,
                              arguments: listData[i]);
                          if (result as bool? ?? false) {
                            initData();
                          }
                        });
                      },
                      itemCount: listData.length,
                    )),
    );
  }
}

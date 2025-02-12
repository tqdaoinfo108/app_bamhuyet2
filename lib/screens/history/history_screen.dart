import 'package:app_bamnguyet_2/model/base_response.dart';
import 'package:app_bamnguyet_2/model/history_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../components/loading.dart';
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
        title: Text("Lịch sử hoạt động"),
      ),
      body: SafeArea(
          child: isLoading
              ? loadingWidget()
              : ListView.builder(
                  itemBuilder: (c, i) {
                    return HistoryCard(listData[i]);
                  },
                  itemCount: listData.length,
                )),
    );
  }
}

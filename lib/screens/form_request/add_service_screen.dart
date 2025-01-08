import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/screens/form_request/components/service_item.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  List<ServiceModel> listData = [];

  @override
  void initState() {
    super.initState();
    getListService();
  }

  getListService() async {
    var temp = await AppServices.instance.getServicesAll();
    if (temp != null) {
      setState(() {
        listData = temp.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thêm dịch vụ")),
      body: SingleChildScrollView(
        child: Column(
          children: listData.map((e) {
            return ServiceItem(e);
          }).toList(),
        ),
      ),
    );
  }
}

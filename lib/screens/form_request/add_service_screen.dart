import 'package:app_bamnguyet_2/model/base_response.dart';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/route/route_constants.dart';
import 'package:app_bamnguyet_2/screens/form_request/components/service_item.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_snackbar.dart';
import '../../model/service_branch_partner.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen(this.data, {super.key});
  final ServiceBranchPartner data;
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

  Future<bool> onAddService() async {
    List<LstServiceDetails> listService = [];
    List<int> listServicePartner = [];
    for (var item in listData.where((e) => e.isExpand)) {
      item.lstServiceDetails.forEach((z) => z
          .imageBranchService = item.imagePath);
      listService.addAll(item.lstServiceDetails);
      listServicePartner.add(item.serviceID);
    }

    if (listService.isEmpty) {
      SnackbarHelper.showSnackBar(
          "Chọn ít nhất 1 dịch vụ", ToastificationType.error);
      return false;
    }

    if (widget.data.partnerID != 0) {
      var res =
          await AppServices.instance.addServicetoPartner(listServicePartner);
      if (res != null) {
        return true;
      }
    } else {
      var res = await AppServices.instance
          .addService(widget.data.branchID, listService);
      if (res != null) {
        return true;
      }
    }

    return false;
  }

  getListService() async {
    ResponseBase<List<ServiceModel>>? temp =
        await AppServices.instance.getServicesAll();
    if (temp != null) {
      List<int> ids =
          widget.data.initData.map((item) => item.serviceId!).toList();

      for (ServiceModel item in temp.data ?? []) {
        if (item.lstServiceDetails.any((i) => ids.contains(i.serviceId))) {
          item.isExpand = true;

          if (widget.data.partnerID == 0) {
            for (var serviceDetail in item.lstServiceDetails) {
              var first = widget.data.initData
                  .where(
                      (e) => e.serviceDetailId == serviceDetail.serviceDetailId)
                  .firstOrNull;
              if (first != null) {
                serviceDetail.amount = first.amount;
              }
            }
          }
        }
      }

      setState(() {
        listData = temp.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add_service".trans())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: listData.map((e) {
                return ServiceItem(e, widget.data);
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: ElevatedButton(
                onPressed: () async {
                  var res = await onAddService();
                  if (res) {
                    SnackbarHelper.showSnackBar(
                        "success".trans(), ToastificationType.success);
                    Navigator.of(context).pushReplacementNamed(homeScreenRoute);
                  } else {
                    SnackbarHelper.showSnackBar(
                        "send_fail".trans(), ToastificationType.error);
                  }
                },
                child: Text("continue".trans()),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/model/rating_model.dart';
import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../components/custom_modal_bottom_sheet.dart';
import '../../components/rating.dart';
import '../../model/type_service_model.dart';
import '../../model/user_model.dart';
import '../../route/route_constants.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import 'components/employee_card.dart';
import 'components/rating_card.dart';
import 'components/service_detail_popup.dart';
import 'components/servive_card.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen(this.data, {super.key});
  final TypeServiceModel data;
  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  List<ServiceModel> listServiceModel = [];
  List<UserModel> listPartner = [];
  List<RatingModel> listRating = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      initData();
    }
  }

  initData() async {
    var temp =
        await AppServices.instance.getServices(widget.data.typeServiceID);
    setState(() {
      listServiceModel = temp?.data ?? [];
    });

    var parner = (await AppServices.instance.getListPartner())?.data ?? [];

    setState(() {
      listPartner = parner;
    });

    var rs =
        (await AppServices.instance.getListRating(widget.data.typeServiceID))
                ?.data ??
            [];
    setState(() {
      listRating = rs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.typeServiceName),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: listRating.isEmpty ? null : Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  StarRating(starCount: 1, rating: 5),
                  Text("${listRating[0].ratingAverage} (${listRating.length} đánh giá)")
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    itemBuilder: (c, x) {
                      return RatingCard(listRating[x]);
                    },
                    itemCount: listRating.length,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Đặt cộng tác viên yêu thích",
                      style: AppTheme.getTextStyle(context,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Tất cả",
                      ),
                      Icon(Icons.arrow_forward_ios_outlined,
                          size: 16, color: Colors.grey)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.width * .48,
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    itemBuilder: (c, x) {
                      return EmployeeCard(listPartner[x]);
                    },
                    itemCount: listPartner.length,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Đặt theo dịch vụ",
                      style: AppTheme.getTextStyle(context,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              for (var item in listServiceModel)
                ServiceCard(item, () async {
                  await customModalBottomSheet(context,
                      child:
                          ServiceDetailPopup(item.lstServiceDetails, () async {
                        if (!item.lstServiceDetails.any((e) => e.isChoose)) {
                          SnackbarHelper.showSnackBar(
                              "Chọn thời gian để tiếp tục",
                              ToastificationType.error);
                          return;
                        }
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, bookingconfirmscreen,
                            arguments: item);
                      }),
                      height: MediaQuery.of(context).size.height / 2.6);
                }),
              SizedBox(height: 40)
            ],
          ),
        ),
      )),
    );
  }
}

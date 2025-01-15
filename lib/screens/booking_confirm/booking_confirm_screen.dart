import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/route/screen_export.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_snackbar.dart';
import '../../components/network_image_with_loader.dart';
import '../../model/address_model.dart';
import '../../model/service_model.dart';
import '../../services/app_services.dart';
import '../../theme/app_theme.dart';

class BookingConfirmScreen extends StatefulWidget {
  const BookingConfirmScreen(this.data, {super.key});
  final ServiceModel data;
  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  List<AddressModel> list = [];

  late LstServiceDetails itemChoose;
  TimeOfDay timeOfDay = TimeOfDay.now();
  String timeOfDayString = "";
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    onInit();
    itemChoose = widget.data.lstServiceDetails.firstWhere((e) => e.isChoose);
  }

  onCreateBooking() async {
    setState(() {
      isLoading = true;
    });
    var respone = await AppServices.instance.createBooking(
        serviceID: widget.data.serviceID,
        addressID: list.first.userAddressId,
        minute: itemChoose.minute!,
        amount: itemChoose.amount!,
        time: timeOfDay,
        description: descriptionController.text);
    if (respone != null) {
      SnackbarHelper.showSnackBar("Thành công", ToastificationType.success);
      Navigator.pushNamedAndRemoveUntil(
          context, homeScreenRoute, ModalRoute.withName(homeScreenRoute));
    } else {
      SnackbarHelper.showSnackBar(
          "Thất bại, vui lòng liên hệ ban quản trị.", ToastificationType.error);
    }
    setState(() {
      isLoading = false;
    });
  }

  onInit() async {
    var address = await AppServices.instance.getListAddress();
    if (address != null) {
      setState(() {
        list = address.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác nhận đặt lịch"),
      ),
      body: isLoading
          ? loadingWidget()
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                  decoration: BoxDecoration(color: lightGreyColor),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/Address.svg",
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(width: defaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Địa chỉ của bạn",
                              style: AppTheme.getTextStyle(context,
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Text(
                            list.isEmpty
                                ? "Thêm địa chỉ"
                                : "${list.first.address}",
                            style: TextStyle(
                                color:
                                    list.isEmpty ? primaryColor : Colors.grey,
                                fontSize: 14),
                          )
                        ],
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        "assets/icons/miniRight.svg",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .2,
                        height: MediaQuery.of(context).size.width * .2,
                        child: NetworkImageWithLoaderAndRadiusBorder(
                          widget.data.imagePath,
                          radius: BorderRadius.all(Radius.circular(60)),
                        ),
                      ),
                      SizedBox(width: defaultPadding),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Text(widget.data.serviceName,
                                style: AppTheme.getTextStyle(context,
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 10),
                          Text(
                              "${itemChoose.minute} phút (${itemChoose.getAmount}đ)",
                              style:
                                  AppTheme.getTextStyle(context, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/Clock.svg"),
                        SizedBox(width: 4),
                        Text("Ngay bây giờ"),
                        Spacer(),
                        InkWell(
                            onTap: () async {
                              var time = await showTimePicker(
                                  context: context, initialTime: timeOfDay);
                              if (time != null) {
                                timeOfDay = time;
                                setState(() {
                                  timeOfDayString = time.format(context);
                                });
                              }
                            },
                            child: timeOfDayString != ""
                                ? Text(
                                    DateFormat('dd-MM-yyyy')
                                            .format(DateTime.now()) +
                                        " " +
                                        timeOfDayString,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                                : Text("Hẹn lịch",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold)))
                      ],
                    )),
                SizedBox(height: defaultPadding),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/Cash.svg"),
                        SizedBox(width: 4),
                        Text("Hình thức thanh toán"),
                        Spacer(),
                        InkWell(
                            child: Text("Tiền mặt",
                                style: TextStyle(fontWeight: FontWeight.bold)))
                      ],
                    )),
                SizedBox(height: defaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: AppTextField(
                    descriptionController,
                    "Ghi chú",
                    "Ghi chú",
                    maxLines: 3,
                    isShowRequired: false,
                  ),
                ),
                SizedBox(height: defaultPadding * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () async {
                      await onCreateBooking();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Đặt lịch"),
                        Text("(${itemChoose.getAmount}đ")
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/route/screen_export.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
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
  bool isChangeTime = false;
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
    try {
      if (GetStorage().read(userTypeUser) != 4) {
        SnackbarHelper.showSnackBar(
            "CTV và chi nhánh không thể đặt lịch", ToastificationType.warning);
        return;
      }

      if (list.isEmpty) {
        SnackbarHelper.showSnackBar(
            "Chưa chọn địa chỉ", ToastificationType.warning);
        return;
      }

      if (!isChangeTime) {
        timeOfDay = TimeOfDay.now();
      }
      TimeOfDay now = TimeOfDay.now();
      if (isChangeTime &&
          !((timeOfDay.hour >= now.hour ||
              (timeOfDay.hour == now.hour &&
                  timeOfDay.minute + 15 >= now.minute)))) {
        SnackbarHelper.showSnackBar(
            "Thời gian nhỏ hơn hiện tại", ToastificationType.warning);
        return;
      }

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
        SnackbarHelper.showSnackBar("Thất bại, vui lòng liên hệ ban quản trị.",
            ToastificationType.error);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                InkWell(
                  onTap: () async {
                    var result = await Navigator.pushNamed(
                        context, addressScreenRoute,
                        arguments: true);
                    if (result != null) {
                      setState(() {
                        list[0] = result as AddressModel;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(color: lightGreyColor),
                    child:  ListTile(
                      trailing: SvgPicture.asset(
                        "assets/icons/miniRight.svg",
                      ),
                      leading:  SvgPicture.asset(
                        "assets/icons/Address.svg",
                        height: 42,
                        width: 42,
                      ),
                      title: Column(
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
                    ),
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
                                isChangeTime = true;
                                setState(() {
                                  timeOfDayString = time.format(context);
                                });
                              }
                            },
                            child: timeOfDayString != ""
                                ? Text(
                                    timeOfDayString +
                                        " " +
                                        DateFormat('dd-MM-yyyy')
                                            .format(DateTime.now()),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      await onCreateBooking();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Đặt lịch"),
                        Text(
                          "${itemChoose.getAmount}đ",
                          style: AppTheme.getTextStyle(context,
                                  fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

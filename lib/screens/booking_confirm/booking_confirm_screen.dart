import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/route/screen_export.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/app_snackbar.dart';
import '../../components/custom_modal_bottom_sheet.dart';
import '../../components/network_image_with_loader.dart';
import '../../model/address_model.dart';
import '../../model/service_model.dart';
import '../../services/app_services.dart';
import '../../theme/app_theme.dart';
import 'booking_confirm_choose_customer.dart';

class BookingConfirmScreen extends StatefulWidget {
  const BookingConfirmScreen(this.data, {super.key});
  final ServiceModel data;
  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  List<AddressModel> list = [];

  late LstServiceDetails itemChoose;
  DateTime timeBooking = DateTime.now();
  bool isChangeTime = false;
  String timeOfDayString = "";
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  UserModel? userModel = null;

  @override
  void initState() {
    super.initState();
    onInit();
    itemChoose = widget.data.lstServiceDetails.firstWhere((e) => e.isChoose);
  }

  onCreateBooking() async {
    try {
      if (list.isEmpty) {
        SnackbarHelper.showSnackBar(
            "choose_address".trans(), ToastificationType.warning);
        return;
      }

      if (!isChangeTime) {
        timeBooking = DateTime.now();
      }

      setState(() {
        isLoading = true;
      });
      var respone = await AppServices.instance.createBooking(
          serviceID: widget.data.serviceID,
          addressID: list.first.userAddressId,
          minute: itemChoose.minute!,
          amount: itemChoose.amount!,
          time: timeBooking,
          userIDBooking: userModel == null
              ? GetStorage().read(userUserID)
              : userModel!.userID,
          branchID: (userModel == null || widget.data.branchID == null)
              ? 0
              : widget.data.branchID ?? 0,
          userIDProcess: (userModel == null ||
                  widget.data.branchID != null ||
                  GetStorage().read(userTypeUser) == 3)
              ? 0
              : GetStorage().read(userUserID),
          description: descriptionController.text);
      if (respone != null) {
        SnackbarHelper.showSnackBar(
            "success".trans(), ToastificationType.success);
        Navigator.pushNamedAndRemoveUntil(
            context, homeScreenRoute, ModalRoute.withName(homeScreenRoute));
      } else {
        SnackbarHelper.showSnackBar(
            "faild_contact_admin".trans(), ToastificationType.error);
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
        title: Text("confirm_booking".trans()),
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
                    child: ListTile(
                      trailing: SvgPicture.asset(
                        "assets/icons/miniRight.svg",
                      ),
                      leading: SvgPicture.asset(
                        "assets/icons/Address.svg",
                        height: 42,
                        width: 42,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("your_address".trans(),
                              style: AppTheme.getTextStyle(context,
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Text(
                            list.isEmpty
                                ? "add_address".trans()
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
                              "${itemChoose.minute} " +
                                  " (${itemChoose.getAmount}đ)",
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
                        Text("now".trans()),
                        Spacer(),
                        InkWell(
                            onTap: () async {
                              DatePicker.showDatePicker(
                                context,
                                onMonthChangeStartWithFirstDate: true,
                                minDateTime: DateTime.now(),
                                maxDateTime:
                                    DateTime.now().add(Duration(days: 15)),
                                initialDateTime: DateTime.now(),
                                dateFormat: "HH:mm dd/MM/yyyy",
                                locale: DateTimePickerLocale.vi,
                                onClose: () => print("----- onClose -----"),
                                onCancel: () => print('onCancel'),
                                pickerTheme: DateTimePickerTheme.Default,
                                onChange: (dateTime, List<int> index) {
                                  setState(() {
                                    timeBooking = dateTime;
                                    isChangeTime = true;
                                    timeOfDayString =
                                        DateFormat("HH:mm dd/MM/yyyy")
                                            .format(dateTime);
                                  });
                                },
                                onConfirm: (dateTime, List<int> index) {
                                  setState(() {
                                    timeBooking = dateTime;
                                    isChangeTime = true;
                                    timeOfDayString =
                                        DateFormat("HH:mm dd/MM/yyyy")
                                            .format(dateTime);
                                  });
                                },
                              );
                            },
                            child: timeOfDayString != ""
                                ? Text(
                                    timeOfDayString +
                                        " " +
                                        DateFormat('').format(DateTime.now()),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                                : Text("choose_time".trans(),
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
                        Text("payment_method".trans()),
                        Spacer(),
                        InkWell(
                            child: Text("cash".trans(),
                                style: TextStyle(fontWeight: FontWeight.bold)))
                      ],
                    )),
                if (GetStorage().read(userTypeUser) == 2 ||
                    GetStorage().read(userTypeUser) == 3)
                  SizedBox(height: defaultPadding),
                if (GetStorage().read(userTypeUser) == 2 ||
                    GetStorage().read(userTypeUser) == 3)
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/Man.svg"),
                          SizedBox(width: 4),
                          Text("Người chỉ định".trans()),
                          Spacer(),
                          InkWell(
                              onTap: () async {
                                var user = await customModalBottomSheet(context,
                                    child: BookingConfirmChooseCustomer(),
                                    isDismissible: false);
                                if (user != null) {
                                  setState(() {
                                    userModel = user;
                                  });
                                }
                              },
                              child: Text(
                                  userModel == null
                                      ? "Chọn khách"
                                      : userModel!.fullName == ''
                                          ? userModel!.getTelephoneMask
                                          : userModel!.fullName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))
                        ],
                      )),
                SizedBox(height: defaultPadding),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: AppTextField(
                    descriptionController,
                    "note".trans(),
                    "note".trans(),
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
                        Text("Booking".trans()),
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
                SizedBox(height: defaultPadding),
                if (widget.data.phoneContact != '')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style:
                          Theme.of(context).elevatedButtonTheme.style?.copyWith(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                // other properties
                              ),
                      onPressed: () async {
                        await launchUrl(
                            Uri(scheme: 'tel', path: widget.data.phoneContact));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('support'.trans() +
                              ": " +
                              widget.data.phoneContact!)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  void initState() {
    super.initState();
    onInit();
    itemChoose = widget.data.lstServiceDetails.firstWhere((e) => e.isChoose);
  }

  onCreateBooking() async {
    timeOfDay = TimeOfDay.now();
    var respone = await AppServices.instance.createBooking(
        serviceID: widget.data.serviceID,
        addressID: list.first.userAddressId,
        minute: itemChoose.minute!,
        amount: itemChoose.amount!,
        time: timeOfDay);
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
      body: Column(
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
                      list.isEmpty ? "Thêm địa chỉ" : "${list.first.address}",
                      style: TextStyle(
                          color: list.isEmpty ? primaryColor : Colors.grey,
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
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
                    Text(widget.data.serviceName,
                        style: AppTheme.getTextStyle(context,
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("${itemChoose.minute} phút (${itemChoose.getAmount}đ)",
                        style: AppTheme.getTextStyle(context, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: defaultPadding),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/Clock.svg"),
                  SizedBox(width: 4),
                  Text("Ngay bây giờ"),
                  Spacer(),
                  InkWell(
                      child: Text("Hẹn lịch",
                          style: TextStyle(color: primaryColor)))
                ],
              )),
          SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Tiếp tục"),
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

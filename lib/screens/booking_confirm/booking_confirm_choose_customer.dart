import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/route/screen_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../components/loading.dart';
import '../../components/network_image_with_loader.dart';
import '../../services/app_services.dart';

class BookingConfirmChooseCustomer extends StatefulWidget {
  const BookingConfirmChooseCustomer({super.key});

  @override
  State<BookingConfirmChooseCustomer> createState() =>
      _BookingConfirmChooseCustomerState();
}

class _BookingConfirmChooseCustomerState
    extends State<BookingConfirmChooseCustomer> {
  List<UserModel> list = [];
  bool isLoading = false;
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    onLoading();
  }

  onLoading({String key = ""}) async {
    try {
      setState(() {
        isLoading = true;
        list = [];
      });
      var address = await AppServices.instance.getListCustomer(keySearch: key);
      if (address != null) {
        setState(() {
          list = address.data!;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("choose_customer".trans()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: IntrinsicHeight(
                child: AppTextField(textController, "search".trans(), "",
                    isShowRequired: false, onChanged: (v) async {
              await onLoading(key: v ?? "");
            })),
          ),
          isLoading
              ? loadingWidget()
              : list.isEmpty
                  ? Center(
                      child: Text("no_data".trans()),
                    )
                  : Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverList.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  onTap: () async {
                                    Navigator.pop(context, list[index]);
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        list[index].fullName == ''
                                            ? "unknow".trans()
                                            : list[index].fullName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        list[index].getTelephoneMask,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  trailing: SvgPicture.asset(
                                    "assets/icons/miniRight.svg",
                                  ),
                                  leading: CircleAvatar(
                                    radius: 28,
                                    child: NetworkImageWithLoader(
                                      list[index].imagePath ?? "",
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: list.length,
                          )
                        ],
                      ),
                    ),
        ],
      ),
    );
  }
}

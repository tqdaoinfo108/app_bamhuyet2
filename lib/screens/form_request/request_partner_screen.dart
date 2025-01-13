import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

import 'components/app_dropdownlist.dart';
import '../../components/app_snackbar.dart';
import '../../components/app_text_field.dart';
import '../../model/service_branch_partner.dart';
import '../../route/route_constants.dart';
import '../../utils/constants.dart';
import 'components/image_card.dart';

class RequestPartnerScreen extends StatefulWidget {
  const RequestPartnerScreen({super.key});

  @override
  State<RequestPartnerScreen> createState() => _RequestPartnerScreenState();
}

class _RequestPartnerScreenState extends State<RequestPartnerScreen> {
  final GlobalKey<ProvinceDropdownlistState> provinceDropdownKey =
      GlobalKey<ProvinceDropdownlistState>();
  final GlobalKey<CityDropdownlistState> cityDropdownKey =
      GlobalKey<CityDropdownlistState>();

  final GlobalKey<_RequestPartnerScreenState> myKey =
      GlobalKey<_RequestPartnerScreenState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController yearBirthController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool gender = true;
  CityModel? city;
  ProvinceModel? province;
  String? imageMain;
  String? image2;
  String? image3;
  String? image4;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var response = await AppServices.instance.getProfile();
    if (response != null) {
      var profile = response.data!;
      setState(() {
        gender = profile.genderID ?? false;
        imageMain = profile.imagePath;
        image2 = profile.lstImageUsers.isNotEmpty
            ? profile.lstImageUsers[0].imagePath
            : null;
        image3 = profile.lstImageUsers.length > 1
            ? profile.lstImageUsers[1].imagePath
            : null;
        image4 = profile.lstImageUsers.length > 2
            ? profile.lstImageUsers[2].imagePath
            : null;
        fullNameController.text = profile.fullName;

        yearBirthController.text = profile.yearBirthday.toString();
        descriptionController.text = profile.description ?? "";
        cityDropdownKey.currentState?.onPickCity(profile.cityId);
        provinceDropdownKey.currentState?.onPickCity(profile.proviceId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cá nhân")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCard(
                image1: imageMain,
                image2: image2,
                image3: image3,
                image4: image4,
                onImage1: (image) {
                  imageMain = image;
                },
                onImage2: (image) {
                  image2 = image;
                },
                onImage3: (image) {
                  image3 = image;
                },
                onImage4: (image) {
                  image4 = image;
                },
              ),
              SizedBox(height: 10),
              AppTextField(fullNameController, "Nguyen Van A", "Họ và tên"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldLabel("Giới tính"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue: gender,
                                activeColor: primaryColor,
                                onChanged: (e) {
                                  setState(() {
                                    gender = e!;
                                  });
                                }),
                            Text(
                              "Nam",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Radio(
                                value: false,
                                groupValue: gender,
                                activeColor: primaryColor,
                                onChanged: (e) {
                                  setState(() {
                                    gender = e!;
                                  });
                                }),
                            Text(
                              "Nữ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: AppTextField(
                          yearBirthController, "1970", "Năm sinh",
                          textInputType: TextInputType.number)),
                ],
              ),
              SizedBox(height: 10),
              TextFieldLabel("Thành phố làm việc"),
              CityDropdownlist(key: cityDropdownKey, (e) {
                setState(() {
                  city = e;
                  provinceDropdownKey.currentState?.oninit(e?.cityId ?? 0);
                });
              }),
              SizedBox(height: 10),
              TextFieldLabel("Quận/ Huyện làm việc"),
              ProvinceDropdownlist((e) {
                province = e;
              }, city?.cityId ?? 0, key: provinceDropdownKey),
              SizedBox(height: 10),
              AppTextField(
                  descriptionController, "Mô tả cá nhân", "Mô tả cá nhân",
                  maxLines: 3),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (fullNameController.text.isEmpty) {
                    SnackbarHelper.showSnackBar(
                        "Chưa nhập họ và tên", ToastificationType.error);
                    return;
                  }

                  if (yearBirthController.text.isEmpty) {
                    SnackbarHelper.showSnackBar(
                        "Chưa nhập năm sinh", ToastificationType.error);
                    return;
                  }

                  if (descriptionController.text.isEmpty) {
                    SnackbarHelper.showSnackBar(
                        "Chưa nhập mô tả cá nhân", ToastificationType.error);
                    return;
                  }

                  if (province == null) {
                    SnackbarHelper.showSnackBar(
                        "Chưa chọn vùng hoạt động", ToastificationType.error);
                    return;
                  }

                  if (imageMain == null &&
                      [image2, image3, image4]
                              .where((image) => image == null || image.isEmpty)
                              .length <
                          2) {
                    SnackbarHelper.showSnackBar(
                        "Chọn ít nhất 1 ảnh đại diện và 2 ảnh khác",
                        ToastificationType.error);
                    return;
                  }

                  var response = await AppServices.instance.updateParther(
                      cityID: city!.cityId!,
                      description: descriptionController.text,
                      fullName: fullNameController.text,
                      genderID: gender,
                      image2: image2 ?? "",
                      image3: image3 ?? "",
                      image4: image4 ?? "",
                      imageRoot: imageMain!,
                      yearBirthday: int.tryParse(yearBirthController.text) ?? 0,
                      provinceID: province!.proviceId!);

                  if (response != null) {
                    SnackbarHelper.showSnackBar(
                        "Thành công", ToastificationType.success);
                    GetStorage().write(userImagePath, imageMain);
                    GetStorage().write(userTypeUser, response.data!.typeUserID);

                    Navigator.popAndPushNamed(context, addServiceScreenRoute,
                        arguments: ServiceBranchPartner(
                            branchID: 0, partnerID: response.data!.userID!));
                  } else {
                    SnackbarHelper.showSnackBar(
                        "Thất bại, vui lòng liên hệ ban quản trị.",
                        ToastificationType.warning);
                  }
                },
                child: const Text("Tiếp tục"),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_dropdownlist.dart';
import '../../components/app_snackbar.dart';
import '../../components/app_text_field.dart';
import '../../services/app_services.dart';
import '../../utils/constants.dart';
import 'components/image_card.dart';
import 'components/time_picker.dart';

class RequestOrganizationScreen extends StatefulWidget {
  const RequestOrganizationScreen({super.key});

  @override
  State<RequestOrganizationScreen> createState() =>
      _RequestOrganizationScreenState();
}

class _RequestOrganizationScreenState extends State<RequestOrganizationScreen> {
  final GlobalKey<ProvinceDropdownlistState> provinceDropdownKey =
      GlobalKey<ProvinceDropdownlistState>();

  final TextEditingController fullNameController =
      TextEditingController(text: "");
  final TextEditingController addressController =
      TextEditingController(text: "");

  final TextEditingController descriptionController =
      TextEditingController(text: "");
  final TextEditingController fbController = TextEditingController(text: "");
  final TextEditingController tiktokController =
      TextEditingController(text: "");
  final TextEditingController websiteController =
      TextEditingController(text: "");
  final TextEditingController youtubeController =
      TextEditingController(text: "");
  final TextEditingController instagramController =
      TextEditingController(text: "");

  TimeOfDay t2t6start = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay t2t6end = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay t7cnstart = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay t7cnend = TimeOfDay(hour: 22, minute: 0);
  CityModel? city;
  ProvinceModel? province;
  String? imageMain;
  String? image2;
  String? image3;
  String? image4;

  @override
  void initState() {
    super.initState();
    onInit();
  }

  onInit() async {
    var position = await _determinePosition();
    var temp =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (temp.isNotEmpty) {
      var place = temp.first;
      String formattedAddress = [
        place.street, // Đường
        place.subLocality, // Phường/Xã
        place.locality, // Quận/Huyện
        place.administrativeArea, // Tỉnh/Thành phố
      ].where((element) => element != null && element.isNotEmpty).join(', ');
      addressController.text = formattedAddress;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tổ chức")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCard(
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
                isPartner: false,
              ),
              SizedBox(height: 10),
              AppTextField(fullNameController, "Chi nhánh A", "Tên tổ chức"),
              SizedBox(height: 10),
              AppTextField(addressController, "Địa chỉ", "Nhập địa chỉ"),
              SizedBox(height: 10),
              TextFieldLabel("Thành phố làm việc"),
              CityDropdownlist((e) {
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
              TextFieldLabel("Thời gian làm việc"),
              TimePickerWidget(
                title: "Thứ 2 - Thứ 6",
                time26s: (e) {
                  t2t6start = e;
                },
                time26e: (e) {
                  t2t6end = e;
                },
                time7cna: (e) {
                  t7cnstart = e;
                },
                time7cne: (e) {
                  t7cnend = e;
                },
                timeofday26s: t2t6start,
                timeofday26e: t2t6end,
                timeofday7cna: t7cnstart,
                timeofday7cne: t7cnend,
              ),
              SizedBox(height: 10),
              AppTextField(descriptionController, "Mô tả", "Mô tả chi nhánh",
                  maxLines: 3),
              SizedBox(height: 10),
              AppTextField(
                websiteController,
                "Nhập địa chỉ website (nếu có)",
                "Nhập địa chỉ website (nếu có)",
                isShowTitle: false,
              ),
              SizedBox(height: 10),
              AppTextField(
                fbController,
                "Nhập địa chỉ facebook (nếu có)",
                "Nhập địa chỉ facebook (nếu có)",
                isShowTitle: false,
              ),
              SizedBox(height: 10),
              AppTextField(
                youtubeController,
                "Nhập địa chỉ youtube (nếu có)",
                "Nhập địa chỉ youtube (nếu có)",
                isShowTitle: false,
              ),
              SizedBox(height: 10),
              AppTextField(
                tiktokController,
                "Nhập địa chỉ tiktok (nếu có)",
                "Nhập địa chỉ tiktok (nếu có)",
                isShowTitle: false,
              ),
              SizedBox(height: 10),
              AppTextField(
                instagramController,
                "Nhập địa chỉ instagram (nếu có)",
                "Nhập địa chỉ instagram (nếu có)",
                isShowTitle: false,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (fullNameController.text.isEmpty) {
                    SnackbarHelper.showSnackBar(
                        "Chưa nhập tên chi nhánh", ToastificationType.error);
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

                  var response = await AppServices.instance.updateBranch(
                      cityID: city!.cityId!,
                      description: descriptionController.text,
                      fullName: fullNameController.text,
                      address: addressController.text,
                      image2: image2 ?? "",
                      image3: image3 ?? "",
                      image4: image4 ?? "",
                      imageRoot: imageMain!,
                      provinceID: province!.proviceId!,
                      timeOfDay1: t2t6start,
                      timeOfDay2: t2t6end,
                      timeOfDay3: t7cnstart,
                      timeOfDay4: t7cnend,
                      fb: fbController.text,
                      instagram: instagramController.text,
                      youtube: youtubeController.text,
                      tiktok: tiktokController.text,
                      ws: websiteController.text);

                  if (response != null) {
                    SnackbarHelper.showSnackBar(
                        "Thành công", ToastificationType.success);
                    GetStorage().write(userImagePath, imageMain);

                    Navigator.pop(context);
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

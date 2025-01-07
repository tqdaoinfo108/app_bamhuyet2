import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../components/app_dropdownlist.dart';
import '../../components/app_text_field.dart';
import '../../utils/constants.dart';
import 'components/image_card.dart';

class RequestOrganizationScreen extends StatefulWidget {
  const RequestOrganizationScreen({super.key});

  @override
  State<RequestOrganizationScreen> createState() =>
      _RequestOrganizationScreenState();
}

class _RequestOrganizationScreenState extends State<RequestOrganizationScreen> {
  final GlobalKey<ProvinceDropdownlistState> provinceDropdownKey =
      GlobalKey<ProvinceDropdownlistState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController yearBirthController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  bool gender = true;

  CityModel? city;

  ProvinceModel? province;

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
                onImage1: () {},
                onImage2: () {},
                onImage3: () {},
                onImage4: () {},
                isPartner: false,
              ),
              SizedBox(height: 10),
              AppTextField(fullNameController, "Chi nhánh A", "Tên tổ chức"),
              SizedBox(height: 10),
              AppTextField(
                  addressController, "Địa chỉ", "1 Đường 1, Quận Thủ Đức"),
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
              ProvinceDropdownlist((e) {}, city?.cityId ?? 0,
                  key: provinceDropdownKey),
              SizedBox(height: 10),
              AppTextField(descriptionController, "Mô tả", "Mô tả chi nhánh",
                  maxLines: 3),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {},
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

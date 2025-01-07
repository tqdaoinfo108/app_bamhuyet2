import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:flutter/material.dart';

import '../../components/app_dropdownlist.dart';
import '../../components/app_text_field.dart';
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

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController yearBirthController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool gender = true;
  CityModel? city;
  ProvinceModel? province;

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
                onImage1: () {},
                onImage2: () {},
                onImage3: () {},
                onImage4: () {},
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
              AppTextField(
                  descriptionController, "Mô tả cá nhân", "Mô tả cá nhân",
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

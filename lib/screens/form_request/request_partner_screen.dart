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
  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cá nhân")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start  ,
            children: [
              ImageCard(
                onImage1: () {},
                onImage2: () {},
                onImage3: () {},
                onImage4: () {},
              ),
              SizedBox(height: 10),
              AppTextField(fullNameController, "Họ và tên"),
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
                        Text.rich(
                          TextSpan(
                            text: "Giới tính",
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                value: true,
                                groupValue: true,
                                activeColor: primaryColor,
                                onChanged: (e) {}),
                            Text("Nam", style: TextStyle(fontSize: 14, color: Colors.grey),),
                            Radio(
                                value: false,
                                groupValue: true,
                                activeColor: primaryColor,
                                onChanged: (e) {}),
                            Text("Nữ",style: TextStyle(fontSize: 14, color: Colors.grey),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: AppTextField(fullNameController, "Năm sinh")),
                ],
              ),
              SizedBox(height: 10),
              TextFieldLabel("Thành phố làm việc"),
              CityDropdownlist((e) {}),
              SizedBox(height: 10),
              TextFieldLabel("Quận/ Huyện làm việc"),
              ProvinceDropdownlist((e) {}, 0),
              SizedBox(height: 10),
              AppTextField(fullNameController, "Mô tả cá nhân", maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }
}

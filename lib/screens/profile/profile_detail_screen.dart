import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/model/base_response.dart';
import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_snackbar.dart';
import '../../services/app_services.dart';
import 'components/profile_widget.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final nameContactController = new TextEditingController();
  UserModel? profile;
  @override
  void initState() {
    super.initState();
    nameContactController.text = GetStorage().read(userFullName);
    onInit();
  }

  onInit() async {
    ResponseBase<UserModel>? p = await AppServices.instance.getProfile();
    if (p != null) {
      setState(() {
        profile = p.data!;
      });
      nameContactController.text = p.data?.fullName ?? "";
    }
  }

  onSave() async {
    bool onResult = await AppServices.instance
        .updateProfile(profile!, nameContactController.text);
    if (onResult) {
      SnackbarHelper.showSnackBar(
          "success".trans(), ToastificationType.success);
      Navigator.of(context).pop(true);
    } else {
      SnackbarHelper.showSnackBar("error".trans(), ToastificationType.error);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("personal_info".trans())),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: GetStorage().read(userImagePath),
              isEdit: true,
              onClicked: () async {
                final _picker = HLImagePicker();
                final images = await _picker.openPicker();
                var response = await AppServices.instance.uploadFile(images.first.path);
                if (response != null) {
                  var response2 = await AppServices.instance.postUpdateAvt
                    (response.data!);
                  if(response2 != null){
                    SnackbarHelper.showSnackBar(
                        "success".trans(), ToastificationType.success);
                    onInit();
                  }else{
                    SnackbarHelper.showSnackBar("cancel".trans(), ToastificationType.warning);
                    return null;
                  }
                } else {
                  SnackbarHelper.showSnackBar("cancel".trans(), ToastificationType.warning);
                  return null;
                }
              },
            ),
            const SizedBox(height: 24),
            AppTextField(
                new TextEditingController(
                    text: GetStorage().read(userUserName)),
                "phone".trans(),
                "phone".trans(),
                enable: false,
                isShowRequired: false),
            const SizedBox(height: 10),
            AppTextField(nameContactController, "full_name".trans(),
                "full_name".trans()),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                await onSave();
              },
              child: Text("save".trans()),
            ),
          ],
        ),
      );
}

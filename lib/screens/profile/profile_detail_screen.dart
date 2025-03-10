import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/model/base_response.dart';
import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
    if(p != null){
      profile = p.data!;
      nameContactController.text = profile!.fullName;
    }
  }

  onSave() async{
    bool onResult = await AppServices.instance.updateProfile(profile!, nameContactController.text );
    if (onResult) {
      SnackbarHelper.showSnackBar(
          "Thao tác thành công", ToastificationType.success);
      Navigator.of(context).pop();
    } else {
      SnackbarHelper.showSnackBar(
          "Thao tác thất bại", ToastificationType.error);
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Thông tin cá nhân")),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: GetStorage().read(userImagePath),
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            AppTextField(new TextEditingController(text: GetStorage().read(userUserName)),"Số điện thoại" ,"Số điện thoại", enable: false, isShowRequired: false),
            const SizedBox(height: 10),
            AppTextField(nameContactController, "Họ và tên", "Họ và tên"),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                await onSave();
              },
              child: const Text("Lưu"),
            ),
          ],
        ),
  );
}

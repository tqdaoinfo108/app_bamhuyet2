import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../components/app_snackbar.dart';
import '../../../model/address_model.dart';
import '../../../utils/constants.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key, this.dataInit});

  final AddressModel? dataInit;
  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  TextEditingController nameContactController = TextEditingController();
  TextEditingController addressContactController = TextEditingController();
  TextEditingController phoneContactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.dataInit != null) {
      nameContactController.text = widget.dataInit!.nameContact;
      addressContactController.text = widget.dataInit!.address;
      phoneContactController.text = widget.dataInit!.phone;
      descriptionController.text = widget.dataInit!.description;
    }
  }

  onSave() async {
    var response = await AppServices.instance.saveAddress(
        nameContactController.text,
        phoneContactController.text,
        addressContactController.text,
        descriptionController.text,
        addressID: widget.dataInit?.userAddressId);
    if (response != null) {
      SnackbarHelper.showSnackBar(
          "Thao tác thành công", ToastificationType.success);
      Navigator.of(context).pop();
    } else {
      SnackbarHelper.showSnackBar(
          "Thao tác thất bại", ToastificationType.error);
    }
  }

  Future<bool> onDelete() async {
    var response = await AppServices.instance
        .deleteAddress(widget.dataInit!.userAddressId);
    return response?.data ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Column(
          children: [
            AppBar(
              title: Text("Chi tiết địa chỉ"),
            ),
            AppTextField(nameContactController, "Họ và tên", "Họ và tên"),
            SizedBox(height: 10),
            AppTextField(addressContactController, "Địa chỉ", "Địa chỉ",
                maxLines: 2),
            SizedBox(height: 10),
            AppTextField(
              phoneContactController,
              "Số điện thoại",
              "Số điện thoại",
              textInputType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            AppTextField(
              descriptionController,
              "Ghi Chú",
              "Ghi Chú",
              textInputType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await onSave();
              },
              child: const Text("Lưu"),
            ),
            SizedBox(height: 10),
            if (widget.dataInit?.userAddressId != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: greyColor),
                onPressed: () async {
                  var response = await onDelete();
                  if (response) {
                    SnackbarHelper.showSnackBar(
                        "Thao tác thành công", ToastificationType.success);
                    Navigator.of(context).pop();
                  } else {
                    SnackbarHelper.showSnackBar(
                        "Thao tác thất bại", ToastificationType.error);
                  }
                },
                child: const Text("Xóa địa chỉ"),
              ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

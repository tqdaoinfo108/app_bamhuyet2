import 'package:app_bamnguyet_2/components/app_text_field.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';
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

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Form(
          key: key,
          child: Column(
            children: [
              AppBar(
                title: Text("address_detail".trans()),
              ),
              AppTextField(nameContactController, "full_name".trans(),
                  "full_name".trans()),
              SizedBox(height: 10),
              AppTextField(addressContactController, "address".trans(),
                  "address".trans(),
                  maxLines: 2),
              SizedBox(height: 10),
              AppTextField(
                phoneContactController,
                "phone".trans(),
                "phone".trans(),
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              AppTextField(
                descriptionController,
                "note".trans(),
                "note".trans(),
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (key.currentState?.validate() ?? false) {
                    await onSave();
                  }
                },
                child: Text("save".trans()),
              ),
              SizedBox(height: 10),
              if (widget.dataInit?.userAddressId != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: greyColor),
                  onPressed: () async {
                    var response = await onDelete();
                    if (response) {
                      SnackbarHelper.showSnackBar(
                          "success".trans(), ToastificationType.success);
                      Navigator.of(context).pop();
                    } else {
                      SnackbarHelper.showSnackBar(
                          "error".trans(), ToastificationType.error);
                    }
                  },
                  child: Text("delete_address".trans()),
                ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

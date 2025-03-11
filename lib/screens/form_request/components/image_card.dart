import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../components/app_snackbar.dart';
import '../../../components/network_image_with_loader.dart';
import '../../../services/app_services.dart';
import '../../../utils/constants.dart';

class ImageCard extends StatefulWidget {
  const ImageCard(
      {required this.onImage1,
      required this.onImage2,
      required this.onImage3,
      required this.onImage4,
      this.isPartner = true,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      super.key});
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;

  final Function(String) onImage1;
  final Function(String) onImage2;
  final Function(String) onImage3;
  final Function(String) onImage4;
  final bool isPartner;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  final _picker = HLImagePicker();

  Future<String?> onPickFile() async {
    final images = await _picker.openPicker();
    var response = await AppServices.instance.uploadFile(images.first.path);
    if (response != null) {
      SnackbarHelper.showSnackBar(
          "success".trans(), ToastificationType.success);
      return response.data;
    } else {
      SnackbarHelper.showSnackBar("cancel".trans(), ToastificationType.warning);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var note = widget.isPartner
        ? "warning_partner_1".trans()
        : "warning_partner_2".trans();
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PickerCardItem(
                func: widget.onImage1,
                isMain: true,
                image: widget.image1,
              ),
              SizedBox(width: 10),
              PickerCardItem(
                func: widget.onImage2,
                isMain: false,
                image: widget.image2,
              ),
              SizedBox(width: 10),
              PickerCardItem(
                  func: widget.onImage3, isMain: false, image: widget.image3),
              SizedBox(width: 10),
              PickerCardItem(
                  func: widget.onImage4, isMain: false, image: widget.image4),
            ],
          ),
        ),
        SizedBox(height: 10),
        HtmlWidget(
          note,
          textStyle: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 14,
            ),
            SizedBox(width: 5),
            Text(
              "chose_least_2_image".trans(),
              style: TextStyle(fontSize: 12, color: Colors.red),
            )
          ],
        )
      ],
    );
  }
}

class PickerCardItem extends StatefulWidget {
  const PickerCardItem(
      {super.key, required this.func, required this.isMain, this.image});

  final Function(String) func;
  final bool isMain;
  final String? image;
  @override
  State<PickerCardItem> createState() => _PickerCardItemState();
}

class _PickerCardItemState extends State<PickerCardItem> {
  final _picker = HLImagePicker();
  String? urlImage = null;
  bool isLoading = false;

  Future<String?> onPickFile() async {
    final images = await _picker.openPicker();
    var response = await AppServices.instance.uploadFile(images.first.path);
    if (response != null) {
      SnackbarHelper.showSnackBar(
          "success".trans(), ToastificationType.success);
      return response.data;
    } else {
      SnackbarHelper.showSnackBar("cancel".trans(), ToastificationType.warning);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          setState(() {
            isLoading = false;
          });
          var image = await onPickFile();
          if (image != null) {
            setState(() {
              urlImage = image;
            });
            widget.func(image);
          }
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultBorderRadious)),
              color: Colors.grey.shade200,
            ),
            height: 120,
            width: 120,
            child: urlImage != null
                ? NetworkImageWithLoader(
                    urlImage!,
                    fit: BoxFit.cover,
                    radius: defaultBorderRadious,
                  )
                : widget.image != null
                    ? NetworkImageWithLoader(
                        widget.image!,
                        fit: BoxFit.cover,
                        radius: defaultBorderRadious,
                      )
                    : isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child:
                                Icon(Icons.add, size: 36, color: Colors.grey),
                          ),
          ),
          if (widget.isMain)
            Container(
              margin: const EdgeInsets.only(bottom: 5, left: 5),
              padding: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(defaultBorderRadious)),
                color: Colors.grey,
              ),
              child: Text(
                "avatar".trans(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

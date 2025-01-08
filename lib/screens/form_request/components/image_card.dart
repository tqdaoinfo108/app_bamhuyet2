import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
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
      super.key});
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
      SnackbarHelper.showSnackBar("Thành công", ToastificationType.success);
      return response.data;
    } else {
      SnackbarHelper.showSnackBar("Huỷ chọn file", ToastificationType.warning);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var note = widget.isPartner
        ? "<html> <body> Lưu ý <ul> <li>Không đăng ảnh ảo, hở hang. Ảnh cần rõ mặt, rõ nét, nghiêm túc</li> <li>Nếu bạn là chủ Spa, phòng khám, thẩm mỹ viện, tiệm hớt tóc, hãy liên hệ chúng tôi để hỗ trợ chuyên sâu</li> </ul> </body> </html>"
        : "<html> <body> Lưu ý <ul> <li>Hãy thêm cơ sở vật chất, không gian của bạn</li></ul> </body> </html>";
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              PickerCardItem(func: widget.onImage1, isMain: true),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage2, isMain: false),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage3, isMain: false),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage4, isMain: false),
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
              "Vui lòng thêm ít nhất 2 ảnh",
              style: TextStyle(fontSize: 12, color: Colors.red),
            )
          ],
        )
      ],
    );
  }
}

class PickerCardItem extends StatefulWidget {
  const PickerCardItem({super.key, required this.func, required this.isMain});

  final Function(String) func;
  final bool isMain;
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
      SnackbarHelper.showSnackBar("Thành công", ToastificationType.success);
      return response.data;
    } else {
      SnackbarHelper.showSnackBar("Huỷ chọn file", ToastificationType.warning);
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
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultBorderRadious)),
                    child: NetworkImageWithLoader(
                      urlImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Icon(Icons.add, size: 36, color: Colors.grey),
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
                "Ảnh đại diện",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}

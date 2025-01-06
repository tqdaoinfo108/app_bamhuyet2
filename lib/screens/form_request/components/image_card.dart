import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../utils/constants.dart';

class ImageCard extends StatefulWidget {
  const ImageCard(
      {required this.onImage1,
      required this.onImage2,
      required this.onImage3,
      required this.onImage4,
      super.key});
  final Function() onImage1;
  final Function() onImage2;
  final Function() onImage3;
  final Function() onImage4;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(defaultBorderRadious)),
                  color: Colors.grey.shade200,
                ),
                height: 120,
                width: 120,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Center(
                      child: Icon(Icons.add, size: 36, color: Colors.grey),
                    ),
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
              ),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage2),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage3),
              SizedBox(width: 10),
              PickerCardItem(func: widget.onImage4),
            ],
          ),
        ),
        SizedBox(height: 10),
        HtmlWidget(
          "<html> <body> Lưu ý <ul> <li>Không đăng ảnh ảo, hở hang. Ảnh cần rõ mặt, rõ nét, nghiêm túc</li> <li>Nếu bạn là chủ Spa, phòng khám, thẩm mỹ viện, tiệm hớt tóc, hãy liên hệ chúng tôi để hỗ trợ chuyên sâu</li> </ul> </body> </html>",
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

class PickerCardItem extends StatelessWidget {
  const PickerCardItem({
    super.key,
    required this.func,
  });

  final Function() func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadious)),
          color: Colors.grey.shade200,
        ),
        height: 120,
        width: 120,
        child: Center(
          child: Icon(Icons.add, size: 36, color: Colors.grey),
        ),
      ),
    );
  }
}

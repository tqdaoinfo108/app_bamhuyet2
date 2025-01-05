import 'package:flutter/material.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/constants.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            height: MediaQuery.of(context).size.width * .25,
            child: NetworkImageWithLoaderAndRadiusBorder(
              "https://cdn.pixabay.com/photo/2022/04/06/11/30/girl-7115394_1280.jpg",
              radius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadious - 2),
                  bottomLeft: Radius.circular(defaultBorderRadious - 2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("Dịch vụ bấm huyệt",
                style: AppTheme.getTextStyle(context,
                    fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          ClipOval(
            child: Material(
              color: primaryColor.withOpacity(.4), // Button color
              child: InkWell(
                splashColor: primaryColor.withOpacity(.8), // Splash color
                onTap: () {},
                child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../components/rating.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/constants.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .3, maxHeight: 120),
      margin: const EdgeInsets.only(right: defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: NetworkImageWithLoaderAndRadiusBorder(
              "https://cdn.pixabay.com/photo/2022/04/06/11/30/girl-7115394_1280.jpg",
              radius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadious - 2),
                  topRight: Radius.circular(defaultBorderRadious - 2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text("Nguyễn Tuấn Vũ",
                style: AppTheme.getTextStyle(context,
                    fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              StarRating(
                starCount: 1,
                rating: 5,
                size: 16,
              ),
              SizedBox(width: 4),
              Text("4.7", style: AppTheme.getTextStyle(context, fontSize: 10)),
              SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "2KM",
                  style: AppTheme.getTextStyle(context, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    ;
  }
}

import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../components/rating.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/constants.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard(this.data, {super.key});
  final UserModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .3, maxHeight: 150),
      margin: const EdgeInsets.only(right: defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.width * .3,
            child: NetworkImageWithLoaderAndRadiusBorder(
              data.imagePath!,
              radius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadious - 2),
                  topRight: Radius.circular(defaultBorderRadious - 2)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text("${data.fullName}",
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
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
    ;
  }
}

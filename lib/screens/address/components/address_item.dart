import 'package:app_bamnguyet_2/model/address_model.dart';
import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddressItem extends StatelessWidget {
  const AddressItem(this.data, this.onCall, {super.key});
  final AddressModel data;
  final Function() onCall;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: InkWell(
        onTap: onCall,
        child: Card(
          color: lightGreyColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 2),
            child:
            ListTile(
              trailing: SvgPicture.asset(
                "assets/icons/miniRight.svg",
                color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.nameContact,
                    style: AppTheme.getTextStyle(context,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(data.address),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

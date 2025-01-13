import 'package:app_bamnguyet_2/model/type_service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../route/route_constants.dart';
import '../../../utils/constants.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(this.data, {super.key});
  final TypeServiceModel data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, serviceDetailScreenRoute);
      },
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultBorderRadious)),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SizedBox.expand(
              child: NetworkImageWithLoader(data.imagePath,
                  radius: defaultBorderRadious),
            ),
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultBorderRadious)),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0.0, -0.1),
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                      Colors.transparent,
                      primaryColor,
                    ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.typeServiceName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SvgPicture.asset(
                    "assets/icons/Arrow - Right.svg",
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

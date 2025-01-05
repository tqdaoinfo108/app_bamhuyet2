import 'package:app_bamnguyet_2/components/network_image_with_loader.dart';
import 'package:flutter/material.dart';

import '../../components/rating.dart';
import '../../theme/app_theme.dart';
import '../../utils/constants.dart';
import 'components/employee_card.dart';
import 'components/rating_card.dart';
import 'components/servive_card.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bấm huyệt tại nhà"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  StarRating(starCount: 1, rating: 5),
                  Text("5 (100 đánh giá)")
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    itemBuilder: (c, x) {
                      return RatingCard();
                    },
                    itemCount: 2,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Đặt cộng tác viên yêu thích",
                      style: AppTheme.getTextStyle(context,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Tất cả",
                      ),
                      Icon(Icons.arrow_forward_ios_outlined,
                          size: 16, color: Colors.grey)
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.width * .42,
                child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    itemBuilder: (c, x) {
                      return EmployeeCard();
                    },
                    itemCount: 6,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Đặt theo dịch vụ",
                      style: AppTheme.getTextStyle(context,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
              ServiceCard(),
            ],
          ),
        ),
      )),
    );
  }
}

import 'package:app_bamnguyet_2/model/service_model.dart';
import 'package:flutter/material.dart';

import 'components/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                return HomeCard(ServiceModel.getServiceList()[index]);
              },
              itemCount: ServiceModel.getServiceList().length,
            )
          ],
        ),
      ),
    );
  }
}

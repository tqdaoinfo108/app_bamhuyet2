import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';

import '../../model/type_service_model.dart';
import 'components/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TypeServiceModel> listService = [];
  @override
  void initState() {
    super.initState();
    getDataInit();
  }

  getDataInit() async {
    var temp = (await AppServices.instance.getTypeServices())?.data ?? [];
    setState(() {
      listService = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemBuilder: (context, index) {
                return HomeCard(listService[index]);
              },
              itemCount: listService.length,
            )
          ],
        ),
      ),
    );
  }
}

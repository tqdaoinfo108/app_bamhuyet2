import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/type_service_model.dart';
import 'components/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TypeServiceModel> listService = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getDataInit();
    }
  }

  getDataInit() async {
    setState(() {
      isLoading = true;
    });
    var temp = (await AppServices.instance.getTypeServices())?.data ?? [];
    setState(() {
      listService = temp;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? loadingWidget()
            : CustomScrollView(
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

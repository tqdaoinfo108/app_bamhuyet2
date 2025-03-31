import 'package:app_bamnguyet_2/model/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/type_service_model.dart';
import '../../services/app_services.dart';
import 'components/branch_card.dart';

class ServiceBranchDetailScreen extends StatefulWidget {
  const ServiceBranchDetailScreen(this.data, {super.key});
  final TypeServiceModel data;

  @override
  State<ServiceBranchDetailScreen> createState() =>
      _ServiceBranchDetailScreenState();
}

class _ServiceBranchDetailScreenState extends State<ServiceBranchDetailScreen> {
  List<BranchModel> listServiceModel = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      initData();
    }
  }

  initData() async {
    var temp = await AppServices.instance.getBranch();
    setState(() {
      listServiceModel = temp?.data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.typeServiceName,
            style: GoogleFonts.openSans(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemBuilder: (c, i) {
          return BranchCard(listServiceModel[i]);
        },
        itemCount: listServiceModel.length,
      ),
    );
  }
}

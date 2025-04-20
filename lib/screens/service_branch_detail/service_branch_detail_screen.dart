import 'package:flutter/material.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import '../../model/branch_model.dart';
import '../../theme/app_theme.dart';

class ServiceBranchServiceScreen extends StatelessWidget {
  final BranchModel data;

  const ServiceBranchServiceScreen(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data.branchName!)),
      body: ListView.builder(
          itemBuilder: (c, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: ListTile(
                title: Text(data.lstBranchServices[i].description!),
                trailing: Text(
                  data.lstBranchServices[i].getAmount,
                  style: AppTheme.getTextStyle(context,
                          fontSize: 16, fontWeight: FontWeight.bold)
                      .copyWith(color: primaryColor),
                ),
              ),
            );
          },
          itemCount: data.lstBranchServices.length),
    );
  }
}

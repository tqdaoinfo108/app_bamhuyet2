import 'package:flutter/material.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import '../../components/network_image_with_loader.dart';
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
                leading: SizedBox(
                  height: 48,
                  width: 48,
                  child: NetworkImageWithLoader(data.lstBranchServices[i]
                      .imageBranchService!),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.lstBranchServices[i].description!),
                    Text(
                    data.lstBranchServices[i].getAmount,
                    style: AppTheme.getTextStyle(context,
                        fontSize: 16, fontWeight: FontWeight.bold)
                        .copyWith(color: primaryColor)),
                  ],
                ),
              ),
            );
          },
          itemCount: data.lstBranchServices.length),
    );
  }
}

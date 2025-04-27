import 'package:flutter/material.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import '../../components/network_image_with_loader.dart';
import '../../model/branch_model.dart';
import '../../model/service_model.dart';
import '../../route/route_constants.dart';
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
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, bookingconfirmscreen,
                    arguments: ServiceModel(
                        data.lstBranchServices[i].serviceId!,
                        data.lstBranchServices[i].description!,
                        data.lstBranchServices[i].imageBranchService!,
                        data.lstBranchServices[i].amount!,
                        [data.lstBranchServices[i]..isChoose = true],
                        "",
                        data.branchId));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: ListTile(
                  leading: SizedBox(
                    height: 48,
                    width: 48,
                    child: NetworkImageWithLoader(
                        data.lstBranchServices[i].imageBranchService!),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.lstBranchServices[i].description!),
                      Text(
                        data.lstBranchServices[i].minute!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontStyle: FontStyle.italic),
                      ),
                      Text(data.lstBranchServices[i].getAmount + "đ",
                          style: AppTheme.getTextStyle(context,
                                  fontSize: 16, fontWeight: FontWeight.bold)
                              .copyWith(color: primaryColor)),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: data.lstBranchServices.length),
    );
  }
}

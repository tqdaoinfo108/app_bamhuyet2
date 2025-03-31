import 'package:app_bamnguyet_2/components/custom_modal_bottom_sheet.dart';
import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../components/network_image_with_loader.dart';
import '../../../model/branch_model.dart';

class BranchCard extends StatelessWidget {
  const BranchCard(this.data, {super.key});
  final BranchModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        customModalBottomSheet(context, child: Scaffold(
          appBar: AppBar(title: Text(data.branchName!)),
          body: ListView.builder(itemBuilder: (c, i){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: ListTile(
                title: Text(data.lstBranchServices[i].description!),
                trailing: Text(data.lstBranchServices[i].getAmount, style:
                AppTheme.getTextStyle(context, fontSize: 16, fontWeight:
                FontWeight.bold).copyWith(color: primaryColor),),
              ),
            );
          }, itemCount: data.lstBranchServices.length),
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 180.0, viewportFraction: 1, autoPlay: true),
                items: data.ImagePathList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: NetworkImageWithLoaderAndRadiusBorder(i,
                              radius: BorderRadius.all(Radius.circular(20))));
                    },
                  );
                }).toList(),
              ),
            ),
            Expanded(
                flex: 6,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.branchName!,
                        style: AppTheme.getTextStyle(context,
                                fontWeight: FontWeight.bold, fontSize: 16)
                            .copyWith(color: primaryColor),
                      ),
                      Text(
                        data.address!,
                        style: AppTheme.getTextStyle(context, fontSize: 14),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.history),
                          Flexible(
                              child: Text("${data.getTime26} (T2-T6)",
                                  style: AppTheme.getTextStyle(context,
                                      fontSize: 14)))
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.history),
                          Flexible(
                              child: Text("${data.getTime7} (T7)",
                                  style: AppTheme.getTextStyle(context,
                                      fontSize: 14)))
                        ],
                      ),

                      Align(alignment: Alignment.centerRight,child: Text("Xem "
                          "chi tiết dịch vụ", style: AppTheme.getTextStyle
                        (context, fontSize: 13).copyWith(fontStyle: FontStyle.italic, color: Colors
                          .grey)),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

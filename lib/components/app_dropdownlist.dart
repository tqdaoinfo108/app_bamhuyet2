import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CityDropdownlist extends StatefulWidget {
  const CityDropdownlist(this.onSelected, {super.key});
  final Function(CityModel?) onSelected;
  @override
  State<CityDropdownlist> createState() => _CityDropdownlistState();
}

class _CityDropdownlistState extends State<CityDropdownlist> {
  List<CityModel> list = [];
  late CityModel valueSelected;
  @override
  void initState() {
    super.initState();
    oninit();
  }

  oninit() async {
    var temp = await AppServices.instance.getListCity();
    if (temp != null) {
      setState(() {
        list = temp.data ?? [];
        valueSelected = list.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? loadingWidget()
        : CustomDropdown<CityModel>(
      hintText: 'Thành phố làm việc',
      items: list,
      initialItem: list[0],
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.cityName ?? "");
      },
      onChanged: (value) {
        widget.onSelected(value);
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: lightGreyColor
      )
    );
  }
}

class ProvinceDropdownlist extends StatefulWidget {
  const ProvinceDropdownlist(this.onSelected, this.cityID, {super.key});
  final Function(ProvinceModel?) onSelected;
  final int cityID;
  @override
  State<ProvinceDropdownlist> createState() => _ProvinceDropdownlist();
}

class _ProvinceDropdownlist extends State<ProvinceDropdownlist> {
  List<ProvinceModel> list = [];
  late ProvinceModel valueSelected;
  @override
  void initState() {
    super.initState();
    oninit();
  }

  oninit() async {
    var temp = await AppServices.instance.getListProvice(widget.cityID);
    if (temp != null) {
      setState(() {
        list = temp.data ?? [];
        valueSelected = list.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? loadingWidget()
        : CustomDropdown<ProvinceModel>(
      hintText: 'Quận/ Phường làm việc',
      items: list,
      initialItem: list[0],
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(item.proviceName ?? "");
      },
      onChanged: (value) {
        widget.onSelected(value);
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: lightGreyColor,
        hintStyle: TextStyle(fontWeight: FontWeight.normal)
      )
    );
  }
}

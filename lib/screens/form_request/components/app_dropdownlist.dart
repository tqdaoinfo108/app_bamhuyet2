import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/city_model.dart';
import 'package:app_bamnguyet_2/model/province_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

import '../../../utils/constants.dart';

class CityDropdownlist extends StatefulWidget {
  const CityDropdownlist(this.onSelected, {super.key});
  final Function(CityModel?) onSelected;
  @override
  State<CityDropdownlist> createState() => CityDropdownlistState();
}

class CityDropdownlistState extends State<CityDropdownlist> {
  List<CityModel?> list = [];
  bool isLoading = false;
  SingleSelectController<CityModel?> controller =
      SingleSelectController<CityModel?>(null);

  @override
  void initState() {
    super.initState();
    oninit();
  }

  onPickCity(int cityID) async {
    while (list.isEmpty) {
      await Future.delayed(Duration(seconds: 1));
    }
    var item = list.firstWhere((e) => e?.cityId == cityID);
    if (list.contains(item)) {
      controller.value = item;
      widget.onSelected(item);
    }
  }

  oninit() async {
    try {
      setState(() {
        isLoading = true;
      });

      if (controller.hasValue) return;
      var temp = await AppServices.instance.getListCity();
      if (temp != null) {
        setState(() {
          list = temp.data ?? [];
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingWidget()
        : CustomDropdown<CityModel?>(
            hintText: 'working_city'.trans(),
            items: list,
            controller: controller,
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(item?.cityName ?? "");
            },
            onChanged: (value) {
              widget.onSelected(value);
            },
            decoration:
                CustomDropdownDecoration(closedFillColor: lightGreyColor));
  }
}

class ProvinceDropdownlist extends StatefulWidget {
  const ProvinceDropdownlist(this.onSelected, this.cityID, {super.key});
  final Function(ProvinceModel?) onSelected;
  final int cityID;
  @override
  State<ProvinceDropdownlist> createState() => ProvinceDropdownlistState();
}

class ProvinceDropdownlistState extends State<ProvinceDropdownlist> {
  List<ProvinceModel?> list = [];
  bool isLoading = false;

  final SingleSelectController<ProvinceModel?> controller =
      SingleSelectController<ProvinceModel?>(null);

  @override
  void initState() {
    super.initState();
    oninit(widget.cityID);
  }

  onPickCity(int provinceID) async {
    while (list.isEmpty) {
      await Future.delayed(Duration(seconds: 1));
    }
    var item = list.firstWhere((e) => e?.proviceId == provinceID);
    if (list.contains(item)) {
      controller.value = item;
    }
  }

  oninit(int cityID) async {
    try {
      if (list.any((e) => e?.cityId == widget.cityID)) return;
      controller.value = null;
      widget.onSelected(null);

      var temp = await AppServices.instance.getListProvice(cityID);
      if (temp != null) {
        setState(() {
          list = temp.data ?? [];
        });
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingWidget()
        : CustomDropdown<ProvinceModel?>(
            hintText: 'working_district_ward'.trans(),
            items: list,
            controller: controller,
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return Text(item?.proviceName ?? "");
            },
            onChanged: (value) {
              widget.onSelected(value);
            },
            decoration: CustomDropdownDecoration(
                closedFillColor: lightGreyColor,
                hintStyle: TextStyle(fontWeight: FontWeight.normal)));
  }
}

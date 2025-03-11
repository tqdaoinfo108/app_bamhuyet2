import 'package:app_bamnguyet_2/route/route_constants.dart';
import 'package:app_bamnguyet_2/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

class EntryPointPopupWidget extends StatefulWidget {
  const EntryPointPopupWidget({super.key});

  @override
  State<EntryPointPopupWidget> createState() => _EntryPointPopupWidgetState();
}

class _EntryPointPopupWidgetState extends State<EntryPointPopupWidget> {
  static const int tochuc = 1;
  static const int canhan = 2;

  int isSelected = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text("who-are-you".trans(),
            style: AppTheme.getTextStyle(context,
                fontSize: 18, fontWeight: FontWeight.bold)),
        RadioListTile(
          value: tochuc,
          groupValue: isSelected,
          onChanged: (e) {
            setState(() {
              isSelected = tochuc;
            });
          },
          title: Text("organization_and_branch".trans()),
        ),
        RadioListTile(
            value: canhan,
            groupValue: isSelected,
            onChanged: (e) {
              setState(() {
                isSelected = canhan;
              });
            },
            title: Text("collaborator".trans())),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () async {
              switch (isSelected) {
                case tochuc:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, requestOrganizationScreen);
                  break;
                case canhan:
                  Navigator.pop(context);
                  Navigator.pushNamed(context, requestPartnerScreen);
                  break;
              }
            },
            child: Text("continue".trans()),
          ),
        ),
      ],
    );
  }
}

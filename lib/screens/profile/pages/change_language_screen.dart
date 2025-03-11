import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String value = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    onLoading();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var langage = context.currentLocale;
      setState(() {
        value = langage.languageCode == 'en' ? "English" : "Tiếng việt";
      });
    });
  }

  onLoading() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("change_language".trans()),
          ),
          body: Column(
            children: [
              RadioListTile<String>(
                title: const Text('Tiếng việt'),
                value: "Tiếng việt",
                groupValue: value,
                onChanged: (String? v) {
                  context.setLocale("vi_VN".toLocale());
                  setState(() {
                    value = v!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('English'),
                value: "English",
                groupValue: value,
                onChanged: (String? v) {
                  context.setLocale("en_US".toLocale());
                  setState(() {
                    value = v!;
                  });
                },
              ),
            ],
          )),
    );
  }
}

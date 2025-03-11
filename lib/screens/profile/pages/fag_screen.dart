import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/model/news_model.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:localization_plus/localization_plus.dart';


class FAGScreen extends StatefulWidget {
  const FAGScreen({super.key, this.modeChoose = false});

  final bool? modeChoose;
  @override
  State<FAGScreen> createState() => _FAGScreenState();
}

class _FAGScreenState extends State<FAGScreen> {
  NewsModel? news = null;
  bool isLoading =  false;
  @override
  void initState() {
    super.initState();
    onLoading();
  }

  onLoading() async {
    try {
      setState(() {
        isLoading = true;
      });
      var address = await AppServices.instance.getNewsList(2);
      if (address != null) {
        setState(() {
          news = address.data![0];
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("terms_of_use".trans()),
        ),
        body: isLoading
            ? loadingWidget()
            : news == null ? Center(child: Text("no_data".trans()),) :  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HtmlWidget(news!.description ?? ""),
            ),
      ),
    );
  }
}

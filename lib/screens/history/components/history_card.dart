import 'package:app_bamnguyet_2/model/history_model.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(this.data, {super.key});
  final HistoryModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            title: Text(data.bookingCode ?? ""),
            trailing: Text("Hoàng thành"),
          ),
          
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget(
      {super.key,
      required this.title,
      required this.time26e,
      required this.time26s,
      required this.time7cna,
      required this.time7cne,
      required this.timeofday26s,
      required this.timeofday26e,
      required this.timeofday7cna,
      required this.timeofday7cne});
  final String title;
  final Function(TimeOfDay) time26s;
  final Function(TimeOfDay) time26e;
  final Function(TimeOfDay) time7cna;
  final Function(TimeOfDay) time7cne;
  final TimeOfDay timeofday26s;
  final TimeOfDay timeofday26e;
  final TimeOfDay timeofday7cna;
  final TimeOfDay timeofday7cne;

  @override
  State<TimePickerWidget> createState() => TimePickerWidgetState();
}

class TimePickerWidgetState extends State<TimePickerWidget> {
  String time26ss = "08:00";
  String time26es = "22:00";
  String time7cnas = "08:00";
  String time7cnes = "22:00";
  var textStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(widget.title, style: textStyle),
            Spacer(),
            InkWell(
                onTap: () async {
                  var time = await showTimePicker(
                      context: context, initialTime: widget.timeofday26s);
                  if (time != null) {
                    setState(() {
                      time26ss = time.format(context);
                    });
                    widget.time26s(time);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        color: lightGreyColor),
                    child: Text(
                      time26ss,
                      style: textStyle,
                    ))),
            Text(" - "),
            InkWell(
                onTap: () async {
                  var time = await showTimePicker(
                      context: context, initialTime: widget.timeofday26e);
                  if (time != null) {
                    setState(() {
                      time26es = time.format(context);
                    });
                    widget.time26e(time);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        color: lightGreyColor),
                    child: Text(
                      time26es,
                      style: textStyle,
                    ))),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Thứ 7 - Chủ nhật",
              style: textStyle,
            ),
            Spacer(),
            InkWell(
                onTap: () async {
                  var time = await showTimePicker(
                      context: context, initialTime: widget.timeofday7cna);
                  if (time != null) {
                    setState(() {
                      time7cnas = time.format(context);
                    });
                    widget.time7cna(time);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        color: lightGreyColor),
                    child: Text(
                      time7cnas,
                      style: textStyle,
                    ))),
            Text(" - "),
            InkWell(
                onTap: () async {
                  var time = await showTimePicker(
                      context: context, initialTime: widget.timeofday7cne);
                  if (time != null) {
                    setState(() {
                      time7cnes = time.format(context);
                    });
                    widget.time7cne(time);
                  }
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        color: lightGreyColor),
                    child: Text(
                      time7cnes,
                      style: textStyle,
                    ))),
          ],
        ),
      ],
    );
  }
}

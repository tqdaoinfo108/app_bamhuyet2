import 'package:app_bamnguyet_2/components/loading.dart';
import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../../components/app_snackbar.dart';
import '../../../components/app_text_field.dart';
import '../../../components/rating.dart';
import '../../../services/app_services.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog(this.bookingID, {super.key});
  final int bookingID;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double rating = 5;
  final TextEditingController descriptionController =
      TextEditingController(text: "");
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingWidget() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(height: 10),
              StarRating(
                rating: rating,
                size: 42,
                onRatingChanged: (rating) => setState(() => this.rating = rating),
              ),
              AppTextField(descriptionController, "description".trans(),
                  "description".trans(),
                  isShowRequired: false,
                  maxLines: 3),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                   try{
                     var rs = await AppServices.instance
                         .postRate(widget.bookingID, descriptionController.text, rating.toInt());
                     if (rs) {
                       SnackbarHelper.showSnackBar(
                           "success".trans(), ToastificationType.success);
                       Navigator.of(context).pop(true);
                     } else {
                       SnackbarHelper.showSnackBar(
                           "error".trans(), ToastificationType.error);
                     }
                   }finally{
                     setState(() {
                       isLoading = false;
                     });
                   }
                  },
                  child: Text("rate".trans()),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

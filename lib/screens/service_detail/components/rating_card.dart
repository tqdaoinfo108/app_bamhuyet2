import 'package:flutter/material.dart';

import '../../../components/rating.dart';
import '../../../model/rating_model.dart';
import '../../../utils/constants.dart';

class RatingCard extends StatelessWidget {
  const RatingCard( this.ratingModel,{ super.key});
  final RatingModel ratingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * .6, maxHeight: 100),
      margin: const EdgeInsets.only(right: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius:
            const BorderRadius.all(Radius.circular(defaultBorderRadious)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StarRating(
            starCount: 5,
            rating: 4,
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          SizedBox(height: 10),
          Text(ratingModel.fullName ?? "")
        ],
      ),
    );
  }
}

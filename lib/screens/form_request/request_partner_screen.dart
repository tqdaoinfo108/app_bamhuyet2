import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'components/image_card.dart';

class RequestPartnerScreen extends StatelessWidget {
  const RequestPartnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cá nhân")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            children: [
              ImageCard(
                onImage1: () {},
                onImage2: () {},
                onImage3: () {},
                onImage4: () {},
              ),
              SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }
}

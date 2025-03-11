import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:app_bamnguyet_2/route/route_constants.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:pinput/pinput.dart';

import '../../utils/constants.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen(this.userModel, {super.key});
  final UserModel userModel;
  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login.jpg",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "register".trans(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  Text(
                    "fill_in_the_information_below_to_continue".trans(),
                  ),
                  const SizedBox(height: defaultPadding),
                  Pinput(
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == widget.userModel.oTP
                          ? null
                          : 'otp_incorrect'.trans();
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) async {},
                  ),
                  const SizedBox(height: defaultPadding),
                  const SizedBox(height: defaultPadding * 2),
                  ElevatedButton(
                    onPressed: () async {
                      var temp = await AppServices.instance
                          .postVerifyOTP(widget.userModel.oTP!);
                      if (temp != null) {
                        GetStorage box = new GetStorage();
                        box.write(userUserName, temp.data!.userName);
                        box.write(userImagePath, temp.data!.imagePath);
                        box.write(userUserID, temp.data!.userID);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            changepasswordscreen,
                            ModalRoute.withName(changepasswordscreen));
                      }
                    },
                    child: Text("continue".trans()),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

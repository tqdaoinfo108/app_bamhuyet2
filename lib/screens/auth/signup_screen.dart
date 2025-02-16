import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toastification/toastification.dart';

import '../../components/loading.dart';
import '../../model/user_model.dart';
import '../../route/route_constants.dart';
import '../../utils/constants.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  UserModel userModel = UserModel();

  bool isLoading = false;

  Future<bool> onRegister() async {
    setState(() {
      isLoading = true;
    });
    var temp = await AppServices.instance.letRegister(phoneController.text);
    if (temp != null && temp.message == null) {
      userModel = temp.data!;
      GetStorage().write(userUserID, userModel.userID);
    }else if(temp?.message != null){
      SnackbarHelper.showSnackBar(temp?.message, ToastificationType.error);
      temp = null;
    }
    setState(() {
      isLoading = false;
    });
    return temp != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? loadingWidget()
          : SingleChildScrollView(
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
                          "Đăng ký tài khoản",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                          "Điền thông tin bên dưới để tiếp tục",
                        ),
                        const SizedBox(height: defaultPadding),
                        SignUpForm(
                            formKey: _formKey,
                            phoneController: phoneController),
                        const SizedBox(height: defaultPadding),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       onChanged: (value) {},
                        //       value: false,
                        //     ),
                        //     Expanded(
                        //       child: Text.rich(
                        //         TextSpan(
                        //           text: "Tôi đồng ý với",
                        //           children: [
                        //             TextSpan(
                        //               recognizer: TapGestureRecognizer()
                        //                 ..onTap = () {
                        //                   // Navigator.pushNamed(
                        //                   //     context, termsOfServicesScreenRoute);
                        //                 },
                        //               text: " điều khoản và dịch vụ ",
                        //               style: const TextStyle(
                        //                 color: primaryColor,
                        //                 fontWeight: FontWeight.w500,
                        //               ),
                        //             ),
                        //             const TextSpan(
                        //               text: "& chính sách bảo mật.",
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(height: defaultPadding * 2),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var result = await onRegister();
                              if (result) {
                                Navigator.pushNamed(
                                    context, verificationMethodScreenRoute,
                                    arguments: userModel);
                              } else {}
                            }
                          },
                          child: const Text("Tiếp tục"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Bạn đã có tài khoản"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, logInScreenRoute);
                              },
                              child: const Text("Đăng nhập"),
                            )
                          ],
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

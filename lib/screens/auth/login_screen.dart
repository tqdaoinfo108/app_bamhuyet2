import 'package:app_bamnguyet_2/services/app_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';

import '../../components/app_snackbar.dart';
import '../../components/loading.dart';
import '../../route/route_constants.dart';
import '../../utils/constants.dart';
import 'components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  onLogin() async {
    setState(() {
      isLoading = true;
    });
    var temp = await AppServices.instance
        .letLogin(phoneController.text, passwordController.text);
    if (temp != null) {
      GetStorage box = new GetStorage();
      box.write(userUserName, temp.data!.userName);
      box.write(userImagePath, temp.data!.imagePath);
      box.write(userUserID, temp.data!.userID);
      return true;
    }
    setState(() {
      isLoading = false;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? loadingWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/login.jpg",
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "welcome_back".trans(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          "login_with_registered_info".trans(),
                        ),
                        const SizedBox(height: defaultPadding),
                        LogInForm(
                          formKey: _formKey,
                          phoneController: phoneController,
                          passwordController: passwordController,
                        ),
                        // Align(
                        //   child: TextButton(
                        //     child: Text("forgot_password".trans()),
                        //     onPressed: () {
                        //       Navigator.pushNamed(
                        //           context, passwordRecoveryScreenRoute);
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: size.height > 700
                              ? size.height * 0.1
                              : defaultPadding,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var temp = await onLogin();
                              if (temp) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    homeScreenRoute,
                                    ModalRoute.withName(logInScreenRoute));
                              } else {
                                SnackbarHelper.showSnackBar(
                                    "account_or_password_incorrect".trans(),
                                    ToastificationType.error);
                              }
                            }
                          },
                          child:  Text("login".trans()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text("dont_have_account".trans()),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, signUpScreenRoute);
                              },
                              child:  Text("register".trans()),
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

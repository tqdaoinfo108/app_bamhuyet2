import 'package:app_bamnguyet_2/components/app_snackbar.dart';
import 'package:app_bamnguyet_2/screens/auth/components/change_pass_form.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../components/loading.dart';
import '../../route/route_constants.dart';
import '../../services/app_services.dart';
import '../../utils/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController newAgianPassword = TextEditingController();

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
                    "Đặt mật khẩu",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Khởi tạo mật khẩu",
                  ),
                  const SizedBox(height: defaultPadding),
                  ChangePassForm(
                    formKey: _formKey,
                    passwordController: newPassword,
                    passwordAgianController: newAgianPassword,
                  ),

                  SizedBox(
                    height: size.height > 700
                        ? size.height * 0.1
                        : defaultPadding,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var rs = AppServices.instance.createPassword(newPassword.text);
                        if(rs != null){
                          SnackbarHelper.showSnackBar("Cập nhật thành công", ToastificationType.success);
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              homeScreenRoute,
                              ModalRoute.withName(changepasswordscreen));
                        }else{
                          SnackbarHelper.showSnackBar("Cập nhật thất bại", ToastificationType.error);
                        }
                      }
                    },
                    child: const Text("Tiếp tục"),
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

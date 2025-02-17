import 'package:app_bamnguyet_2/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization_plus/localization_plus.dart';
import 'package:toastification/toastification.dart';
import './route/router.dart' as router;

import 'route/route_constants.dart';
import 'theme/app_theme.dart';

void main() async {
  await GetStorage.init();
  LocalizationPlusController controller = await LocalizationPlusController.init(
      path: 'assets/i18n',
      supportedLocales: ['en_US'.toLocale(), 'vi-VN'.toLocale()],
      saveLocale: true,
      useOnlyLangCode: true);

  runApp(LocalizationPlus(controller: controller, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bấm huyệt Hoàng Lâm',
        theme: AppTheme.lightTheme(context),
        locale: context.currentLocale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        themeMode: ThemeMode.light,
        onGenerateRoute: router.generateRoute,
        initialRoute: GetStorage().read(userUserID) != null
            ? homeScreenRoute
            : logInScreenRoute,
      ),
    );
  }
}

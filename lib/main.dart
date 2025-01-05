import 'package:flutter/material.dart';
import './route/router.dart' as router;

import 'route/route_constants.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bấm huyệt Hoàng Lâm',
      theme: AppTheme.lightTheme(context),
      themeMode: ThemeMode.light,
      onGenerateRoute: router.generateRoute,
      initialRoute: logInScreenRoute,
    );
  }
}

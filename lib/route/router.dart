import 'package:app_bamnguyet_2/screens/auth/signup_screen.dart';
import 'package:app_bamnguyet_2/screens/home/home_screen.dart';
import 'package:app_bamnguyet_2/screens/service_detail/service_detail_screen.dart';
import 'package:flutter/material.dart';

import '../entry_point.dart';
import 'route_constants.dart';
import 'screen_export.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case logInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EntryPoint(),
      );
    case serviceDetailScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ServiceDetailScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  }
}

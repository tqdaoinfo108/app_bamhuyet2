import 'package:app_bamnguyet_2/model/user_model.dart';
import 'package:app_bamnguyet_2/screens/auth/signup_screen.dart';
import 'package:app_bamnguyet_2/screens/auth/verification_code_screen.dart';
import 'package:app_bamnguyet_2/screens/form_request/add_service_screen.dart';
import 'package:app_bamnguyet_2/screens/form_request/request_organization_screen.dart';
import 'package:app_bamnguyet_2/screens/form_request/request_partner_screen.dart';
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
    case verificationMethodScreenRoute:
      final args = settings.arguments as UserModel;
      return MaterialPageRoute(
        builder: (context) => VerificationCodeScreen(args),
      );
    case requestOrganizationScreen:
      return MaterialPageRoute(
        builder: (context) => RequestOrganizationScreen(),
      );
    case requestPartnerScreen:
      return MaterialPageRoute(
        builder: (context) => RequestPartnerScreen(),
      );
    case addServiceScreenRoute:
      return MaterialPageRoute(
        builder: (context) => AddServiceScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  }
}

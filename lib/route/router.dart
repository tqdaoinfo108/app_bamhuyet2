import 'package:app_bamnguyet_2/model/address_model.dart';
import 'package:flutter/material.dart';
import '../model/service_model.dart';
import '../model/type_service_model.dart';
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
      final args = settings.arguments as TypeServiceModel;

      return MaterialPageRoute(
        builder: (context) => ServiceDetailScreen(args),
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
      final args = settings.arguments as ServiceBranchPartner;
      return MaterialPageRoute(
        builder: (context) => AddServiceScreen(args),
      );
    case addressScreenRoute:
      return MaterialPageRoute(
        builder: (context) => AddressScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_clean_arch_revision2/app/di.dart';
import 'package:flutter_clean_arch_revision2/presentation/forget_password/view/forget_password_view.dart';
import 'package:flutter_clean_arch_revision2/presentation/login/view/login_view.dart';
import 'package:flutter_clean_arch_revision2/presentation/main/main_view.dart';
import 'package:flutter_clean_arch_revision2/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_clean_arch_revision2/presentation/register/view/register_view.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_arch_revision2/presentation/store_details/store_details_view/store_details.dart';

import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "onBoarding";
  static const String loginRoute = "login";
  static const String forgetPasswordhRoute = "forgetPassword";
  static const String mainhRoute = "main";
  static const String registerhRoute = "register";
  static const String storeDetailsRoute = "storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginRoute:
        initloginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.forgetPasswordhRoute:
        initForgetPassword();
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case Routes.mainhRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.registerhRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRoureFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRoureFound),
              ),
            ));
  }
}

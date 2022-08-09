import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_arch_revision2/app/app_prefs.dart';
import 'package:flutter_clean_arch_revision2/app/di.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/assets_manger.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/color_manager.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/constant_manager.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/routes_manager.dart';
import 'package:flutter_clean_arch_revision2/presentation/resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreference _appPreference = instance<AppPreference>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), _goNext);
  }

  _goNext() {
    _appPreference.istUserLoggedIn().then((istUserLoggedIn) => {
          if (istUserLoggedIn)
            {
              Navigator.pushReplacementNamed(context, Routes.mainhRoute),
            }
          else
            {
              _appPreference
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute),
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute),
                          }
                      }),
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
        ),
      ),
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

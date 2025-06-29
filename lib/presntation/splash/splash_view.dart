import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive/app/app_prefs.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/color_manager.dart';
import 'package:responsive/presntation/resources/routes_manager.dart';

import '../resources/constant_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              if (mounted)
                Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to main screen
                            if (mounted)
                              Navigator.pushReplacementNamed(
                                  context, Routes.loginRoute)
                          }
                        else
                          {
                            // navigate to main onBoarding
                            if (mounted)
                              Navigator.pushReplacementNamed(
                                  context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: ConstantManager.s3), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      body: const Center(
          child: SizedBox(
              width: 190,
              child: Image(image: AssetImage(ImageAssets.splashLogo)))),
    );
  }
}

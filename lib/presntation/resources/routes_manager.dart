import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/add_robot/add_robot_view/add_robot_view.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/home/home_view/home_view.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/setting/view/setting_view.dart';

import '../../app/di.dart';
import '../configration/config_view/config_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';

import '../onboarding/view/onboarding_view.dart';
import '../splash/splash_view.dart';
import '../store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String homeRoute = "/home";
  static const String storeDetailsRoute = "/storeDetails";
  static const String settingRoute = "/setting";
  static const String configuration = "/configuration";
  static const String addRobot = "/addRobot";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    initLoginModule();
    initUpdateMapModule();
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.mainRoute: 
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      case Routes.settingRoute:
        return MaterialPageRoute(builder: (_) => const SettingView());
      case Routes.configuration:
        initUpdateMapModule();
        return MaterialPageRoute(builder: (_) => const ConfigView());
      case Routes.addRobot:
        return MaterialPageRoute(builder: (_) {
          return BlocProvider(
            create: (context) => AddRobotCubit(),
            child: const AddRobotView(),
          );
        });
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}

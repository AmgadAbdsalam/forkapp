import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/common/scroll_behavior/scroll_behavior.dart';
import 'package:responsive/presntation/current_missions/cubit/add_mission_cubit/add_mission_cubit.dart';
import 'package:responsive/presntation/setting/cubit/setting_cubit.dart';
import '../presntation/resources/routes_manager.dart';
import '../presntation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const _instance = MyApp._internal();
  factory MyApp() => _instance;
//////
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return  BlocProvider(
            create: (context) => AddMissionCubit(),
            child: MaterialApp(
                        scrollBehavior: MyCustomScrollBehavior(),
                        debugShowCheckedModeBanner: false,
                        onGenerateRoute: RouteGenerator.getRoute,
                        initialRoute: Routes.splashRoute,
                        theme: getApplicationTheme(context),
                      ),
          );
        },
      ),
    );
  }
}

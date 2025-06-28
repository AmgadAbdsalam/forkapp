import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/common/scroll_behavior/scroll_behavior.dart';
import 'package:responsive/presntation/current_missions/cubit/add_mission_cubit/add_mission_cubit.dart';
import 'package:responsive/presntation/setting/cubit/setting_cubit.dart';
import '../presntation/resources/routes_manager.dart';
import '../presntation/resources/theme_manager.dart';
import 'app_prefs.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();
  static const _instance = MyApp._internal();
  factory MyApp() => _instance;
//////
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences=instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local)=>{context.setLocale(local)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return  BlocProvider(
            create: (context) => AddMissionCubit(),
            child: MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_cubit/current_missions_cubit.dart';
import 'package:responsive/presntation/home/home_view/home_view.dart';
import 'package:responsive/presntation/setting/view/setting_view.dart';

import '../../app/di.dart';
import '../current_missions/current_missions_view/add_mission_view.dart';
import '../add_robot/add_robot_view/add_robot_view.dart';
import '../resources/strings_manager.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView> {
  @override
  void initState() {
    initMapDataModule();
    initEditNodeModule();
    initUpdateMapModule();
    super.initState();
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeView(),
    const SettingView(),
    BlocProvider(
      create: (context) =>  AddRobotCubit(),
      child: const AddRobotView(),
    ),
    BlocProvider(
      create: (context) => CurrentMissionsCubit(),
      child: const CurrentMissionView(),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
           BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: AppStrings.home.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: AppStrings.setting.tr()),
           BottomNavigationBarItem(
              icon: const Icon(Icons.control_point), label: AppStrings.addRobot.tr()),
           BottomNavigationBarItem(
              icon: const Icon(Icons.cabin), label: AppStrings.addMission.tr()),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

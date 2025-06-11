import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/home/home_view/home_view.dart';
import 'package:responsive/presntation/setting/view/setting_view.dart';

import '../../app/di.dart';
import '../current_missions/current_missions_view/add_mission_view.dart';
import '../add_robot/add_robot_view/add_robot_view.dart';

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
  final List<Widget> _screens = const [
    HomeView(),
    SettingView(),
    AddRobotView(),
    CurrentMissionView(),
  ];
  static const List<String> appBarText = [
    'Home',
    'Setting',
    'Add Robot',
    'Current Mission'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _currentIndex == 0
      //     ? AppBar(
      //         title: Text(appBarText[_currentIndex]),
      //         centerTitle: false,
      //         actions: [
      //           IconButton(onPressed: (){}, icon: const Icon(Icons.add)),
      //           IconButton(onPressed: (){}, icon: const Icon(Icons.remove)),
      //         ],
      //       )
      //     : AppBar(
      //         title: Text(appBarText[_currentIndex]),
      //         centerTitle: false,
      //       ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.control_point), label: 'Add Robot'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cabin), label: 'Add Mission'),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}

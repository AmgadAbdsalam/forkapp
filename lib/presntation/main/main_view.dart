import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/presntation/configration/config_view/config_view.dart';
import 'package:responsive/presntation/home/home_view/home_view.dart';
import 'package:responsive/presntation/setting/view/setting_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends ConsumerState<MainView> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    HomeView(),
    SettingView(),
    ConfigView(),
  ];
  static const List<String> appBarText = [
    'Home',
    'Setting',
    'Configuration',
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
        onTap: (index) {
          setState(() {});
          _currentIndex = index;
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
              icon: Icon(Icons.control_point), label: 'Configuration'),
        ],
        currentIndex: _currentIndex,
      ),
      body: _screens[_currentIndex],
    );
  }
}

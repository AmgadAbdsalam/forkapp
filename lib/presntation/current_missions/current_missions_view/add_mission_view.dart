import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';

class CurrentMissionView extends StatefulWidget {
  const CurrentMissionView({super.key});

  @override
  State<CurrentMissionView> createState() => _CurrentMissionViewState();
}

class _CurrentMissionViewState extends State<CurrentMissionView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MissionInfo extends StatelessWidget {
  final RobotRequest robot;
  const MissionInfo({super.key, required this.robot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(robot.id),
      leading: SvgPicture.asset('assets/images/robot.svg', width: 40, height: 40),
    );
  }
}

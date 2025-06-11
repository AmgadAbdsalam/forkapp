import 'package:flutter/material.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/presntation/current_missions/widgets/mission_info.dart';

class MissionsListView extends StatelessWidget {
  final List<Robot> robots;
  const MissionsListView({
    super.key,
    required this.robots,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: robots.length,
      itemBuilder: (context, index) {
        final robot = robots[index];
        return MissionInfo(robot: robot);
      },
    );
  }
}

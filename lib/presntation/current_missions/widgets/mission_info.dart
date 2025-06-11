import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';

class MissionInfo extends StatelessWidget {
  final Robot robot;
  const MissionInfo({super.key, required this.robot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(robot.robotData.id,
          style: Theme.of(context).textTheme.displayMedium),
      leading: SvgPicture.asset(ImageAssets.robotImage, width: 40, height: 40),
      subtitle: Text(
        'Destination: ${robot.destination}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

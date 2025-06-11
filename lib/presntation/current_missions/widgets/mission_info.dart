import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';

class MissionInfo extends StatelessWidget {
  final Robot robot;
  const MissionInfo({super.key, required this.robot});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,
      child: ListTile(
        titleTextStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(color: Colors.white),
        subtitleTextStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          'Robot ID: ${robot.robotData.id}',
        ),
        leading:
            SvgPicture.asset(ImageAssets.robotImage, width: 40, height: 40),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Destination: ${robot.destination}'),
            Text('Current location: ${robot.location}'),
          ],
        ),
      ),
    );
  }
}

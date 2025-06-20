import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/color_manager.dart';

class RobotItem extends StatelessWidget {
  const RobotItem({
    required this.robot,
    super.key, required this.isConnected,
  });

  final RobotRequest robot;
  final bool isConnected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ListTile(

        selected: true,


        //style: ListTileStyle.list,
        trailing: isConnected ? null : IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            BlocProvider.of<AddRobotCubit>(context).addRobotToDatabase(Robot(
                destination: "",
                hasError: false,
                isAvailable: true,
                isCarry: false,
                isCharging: false,
                location: '${robot.x}_${robot.y}',
                robotData: RobotData(
                    batteryLevel: robot.batteryLevel,
                    dimensions: Dimensions(height: 100, width: 100),
                    id: robot.id,
                    maxWeight: 100)));
          },
        ),
        tileColor: ColorManager.lightLightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Robot ID: ${robot.id}',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        subtitle: Text('Battery Level: ${robot.batteryLevel}'),
        leading: SvgPicture.asset(
          ImageAssets.robotImage,
          semanticsLabel: 'robot',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/resources/assets_manager.dart';
import 'package:responsive/presntation/resources/color_manager.dart';

class RobotItem extends StatelessWidget {
  const RobotItem({
    required this.robot,
    super.key,
  });
  final RobotRequest robot;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          BlocProvider.of<AddRobotCubit>(context).addRobotToDatabase(robot);
         
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
        ImageAssets.robotImmage,
        semanticsLabel: 'robot',
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/presntation/add_robot/add_robot_view/widgets/robot_item.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class RobotsListView extends StatelessWidget {
  const RobotsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(

      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      children: [
         const SizedBox(height: AppPadding.p16),
        Text(
         AppStrings.connectedRobot.tr() ,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        ...BlocProvider.of<AddRobotCubit>(context)
            .connectedRobots
            .map((robot) => RobotItem(
                  robot: RobotRequest.fromRobot(robot),
                  isConnected: true,
                )),
        const Divider(),
        const SizedBox(height: AppSize.s8),
        Text(
          AppStrings.availableRobots.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ...BlocProvider.of<AddRobotCubit>(context)
            .robots
            .map((robot) => RobotItem(
                  robot: robot,
                  isConnected: false,
                )),
      ],
    );
  }
}

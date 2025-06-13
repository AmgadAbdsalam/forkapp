import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';

import 'package:responsive/presntation/add_robot/add_robot_view/widgets/robot_item.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

class AddRobotView extends StatefulWidget {
  const AddRobotView({super.key});

  @override
  State<AddRobotView> createState() => _AddRobotViewState();
}

class _AddRobotViewState extends State<AddRobotView> {
  @override
  void initState() {
    getRobots();
    super.initState();
  }

  Future<void> getRobots() async {
    var cubit = BlocProvider.of<AddRobotCubit>(context);
    await cubit.accessRobots();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRobotCubit, AddRobotState>(
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.only(
                top: AppPadding.p16, left: AppPadding.p8, right: AppPadding.p8),
            child: BlocBuilder<AddRobotCubit, AddRobotState>(
              builder: (context, state) {
                if (state is AccessRobotLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AccessRobotFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is AccessRobotSuccess) {
                  return RefreshIndicator(
                    triggerMode: RefreshIndicatorTriggerMode.anywhere,
                    onRefresh: () async {
                      await getRobots();
                    },
                    child: ListView(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                      children: [
                        const SizedBox(height: AppPadding.p16),
                        Text(
                          'Connected Robot',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        ...BlocProvider.of<AddRobotCubit>(context)
                            .connectedRobots
                            .map((robot) => RobotItem(
                                  robot: RobotRequest.fromRobot(robot),
                                  isConnected: true,
                                )),
                        const SizedBox(height: AppSize.s16),
                        const Divider(),
                        const SizedBox(height: AppSize.s16),
                        Text(
                          'Available Robots',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        ...BlocProvider.of<AddRobotCubit>(context)
                            .robots
                            .map((robot) => RobotItem(
                                  robot: robot,
                                  isConnected: false,
                                )),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No robots found'),
                  );
                }
              },
            ));
      },
    );
  }
}

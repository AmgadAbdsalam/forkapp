import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Padding(
        padding: const EdgeInsets.only(
            top: AppPadding.p16, left: AppPadding.p8, right: AppPadding.p8),
        child: BlocBuilder<AddRobotCubit, AddRobotState>(
          builder: (context, state) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                await getRobots(); // محاكاة تحميل البيانات
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: AppSize.s16,
                ),
                itemCount:
                    BlocProvider.of<AddRobotCubit>(context).robots.length,
                itemBuilder: (context, index) => RobotItem(
                    robot:
                        BlocProvider.of<AddRobotCubit>(context).robots[index]),
              ),
            );
          },
        ));
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/add_robot/add_robot_view/widgets/robots_list_view.dart';
import 'package:responsive/presntation/add_robot/cubit/add_robot_cubit.dart';
import 'package:responsive/presntation/resources/values_manager.dart';

import '../../resources/strings_manager.dart';

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
                    onRefresh: getRobots,
                    child: const RobotsListView(),
                  );
                } else {
                  return  Center(
                    child: Text(AppStrings.noRobotsFound.tr()),
                  );
                }
              },
            ));
      },
    );
  }
}

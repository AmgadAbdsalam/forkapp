import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_cubit.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_state.dart';
import 'package:responsive/presntation/current_missions/widgets/missions_list_view.dart';

class CurrentMissionView extends StatefulWidget {
  const CurrentMissionView({super.key});

  @override
  State<CurrentMissionView> createState() => _CurrentMissionViewState();
}

class _CurrentMissionViewState extends State<CurrentMissionView> {
  @override
  void initState() {
    BlocProvider.of<CurrentMissionsCubit>(context).loadMissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CurrentMissionsCubit, CurrentMissionsState>(
          builder: (context, state) {
            if (state is CurrentMissionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrentMissionsSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CurrentMissionsCubit>(context).loadMissions();
                },
                child: MissionsListView(robots: state.missions),
              );
            } else if (state is CurrentMissionsFailure) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('No missions available'));
          },
        ),
      ),
    );
  }
}

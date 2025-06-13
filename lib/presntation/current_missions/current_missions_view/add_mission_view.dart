import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/presntation/current_missions/cubit/add_mission_cubit/add_mission_cubit.dart';
import 'package:responsive/presntation/current_missions/cubit/add_mission_cubit/add_mission_state.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_cubit/current_missions_cubit.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_cubit/current_missions_state.dart';
import 'package:responsive/presntation/current_missions/widgets/missions_list_view.dart';

class CurrentMissionView extends StatefulWidget {
  const CurrentMissionView({super.key});

  @override
  State<CurrentMissionView> createState() => _CurrentMissionViewState();
}

class _CurrentMissionViewState extends State<CurrentMissionView> {
  @override
  void initState() {
    BlocProvider.of<CurrentMissionsCubit>(context).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<FormState>();
    int x = 0;
    int y = 0;
    return BlocBuilder<CurrentMissionsCubit, CurrentMissionsState>(
      builder: (context, state) {
        if (state is CurrentMissionsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is CurrentMissionsSuccess) {
          List<Robot> freeRobots = state.freeRobots;
          return Scaffold(
            floatingActionButton:
                BlocListener<AddMissionCubit, AddMissionState>(
              listener: (context, state) {
                if (state is AddMissionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Mission added successfully: ${state.getNearestRobotResponse.robotRequest.id}')),
                  );
                  BlocProvider.of<CurrentMissionsCubit>(context).getData();
                } else if (state is AddMissionFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Text('Add New Mission',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 16),
                              const Text('x of place of product',
                                  style: TextStyle(fontSize: 16)),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid x coordinate';
                                  }
                                  final intValue = int.tryParse(value);
                                  if (intValue == null || intValue < 0) {
                                    return 'Please enter a valid positive integer';
                                  }
                                  return null;
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: false, decimal: false),
                                onChanged: (value) {
                                  x = int.tryParse(value) ?? 0;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Place x',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const Text('y of place of product',
                                  style: TextStyle(fontSize: 16)),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a valid y coordinate';
                                  }
                                  final intValue = int.tryParse(value);
                                  if (intValue == null || intValue < 0) {
                                    return 'Please enter a valid positive integer';
                                  }
                                  return null;
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: false),
                                onChanged: (value) {
                                  y = int.tryParse(value) ?? 0;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Enter Place y',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (key.currentState!.validate()) {
                                      await BlocProvider.of<AddMissionCubit>(
                                              context)
                                          .addMission(freeRobots, x, y);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  child: const Text('Add'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CurrentMissionsCubit>(context).getData();
                },
                child: MissionsListView(robots: state.workingRobots),
              ),
            ),
          );
        } else if (state is CurrentMissionsFailure) {
          return Scaffold(body: Center(child: Text(state.error)));
        }
        return const Center(child: Text('No missions available'));
      },
    );
  }
}

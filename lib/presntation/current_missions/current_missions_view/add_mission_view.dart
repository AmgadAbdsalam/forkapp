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
    return BlocBuilder<CurrentMissionsCubit, CurrentMissionsState>(
      builder: (context, state) {
        if (state is CurrentMissionsLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is CurrentMissionsSuccess) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text('Add New Mission',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 16),
                          const Text('ID of place of product',
                              style: TextStyle(fontSize: 16)),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter Place ID',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const Text('ID of destination',
                              style: TextStyle(fontSize: 16)),
                          const TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter Destination ID',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add mission logic here
                                Navigator.of(context).pop();
                              },
                              child: const Text('Add'),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CurrentMissionsCubit>(context).loadMissions();
                },
                child: MissionsListView(robots: state.missions),
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/fitch_connected_robots.dart';
import 'package:responsive/presntation/current_missions/cubit/current_missions_cubit/current_missions_state.dart';

class CurrentMissionsCubit extends Cubit<CurrentMissionsState> {
  CurrentMissionsCubit() : super(CurrentMissionsInitial());
  
  
  
  void getData() async {
    List<Robot> workingRobots = [];
      List<Robot> freeRobots = [];


    emit(CurrentMissionsLoading());
    
    var response = await FitchConnectedRobots(instance()).execute(null);
    response.fold(
      (failure) => emit(CurrentMissionsFailure(failure.message)),
      (missions) {
        for (var mission in missions) {
          if (mission.destination.isNotEmpty) {
            workingRobots.add(mission);
          } else {
            freeRobots.add(mission);
          }
        }
        emit(CurrentMissionsSuccess(workingRobots, freeRobots));
      },
    );
  }
}

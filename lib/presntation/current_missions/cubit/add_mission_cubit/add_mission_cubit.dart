import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/app/helper_functions.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/map_data_usecase.dart';
import 'package:responsive/presntation/current_missions/cubit/add_mission_cubit/add_mission_state.dart';

class AddMissionCubit extends Cubit<AddMissionState> {
  AddMissionCubit() : super(AddMissionInitial());
  final List<List<int>> _grid =
      List.generate(100, (index) => List.filled(100, 0));

  Future<void> addMission(
    List<Robot> availableRobots,
    int targetX,
    int targetY,
  ) async {
    emit(AddMissionLoading());
    var mapResponse = await MapDataUseCase(instance()).execute(null);
    mapResponse.fold((failure) => emit(AddMissionFailure(failure.message)),
        (r) {
      for (var e in r) {
        _grid[e.xAxis][e.yAxis] = e.isFree ? 1 : 0;
      }
    });
    var response = getNearestRobot(_grid, availableRobots, targetX, targetY);
    response.fold(
      (failure) => emit(AddMissionFailure(failure.message)),
      (getNearestRobotResponse) async {
        try {
          DatabaseReference ref = FirebaseDatabase.instance
              .ref('tasks/${getNearestRobotResponse.robotRequest.id}');
          await ref.set({
            "id": getNearestRobotResponse.robotRequest.id,
            "path": getNearestRobotResponse.pathToTarget.toString()
          });
        } catch (e) {
          emit(AddMissionFailure('Error while adding mission: $e'));
          return;
        }
        emit(AddMissionSuccess(getNearestRobotResponse));
      },
    );
  }
}

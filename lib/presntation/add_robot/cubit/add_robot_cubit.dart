import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/domain/use_cases/delete_robot_usecase.dart';
import 'package:responsive/domain/use_cases/fitch_connected_robots.dart';
import '../../../app/di.dart';
import '../../../domain/use_cases/add_robot_to_database_usecase.dart';

part 'add_robot_state.dart';

class AddRobotCubit extends Cubit<AddRobotState> {
  AddRobotCubit() : super(AddRobotInitial());

  List<RobotRequest> robots = [];
  List<Robot> connectedRobots = [];
  Future<void> addRobotToDatabase(Robot robot) async {
    var response =
        await AddRobotToDatabaseUsecase(repository: instance()).execute(robot);
    response.fold(
      (l) {
        emit(AccessRobotFailure(l.message));
      },
      (r) async {
        await accessRobots();
        emit(AccessRobotSuccess());
      },
    );
  }

  void removeRobot(String id) async {
    emit(AccessRobotLoading());
    var response = await DeleteRobotUseCase(instance()).execute(id);
    response.fold(
      (l) async {
        emit(AccessRobotFailure(l.message));
      },
      (r) {
        connectedRobots.removeWhere((e) => e.robotData.id == id);
        emit(AccessRobotSuccess());
      },
    );
  }

  Future<void> accessRobots() async {
    void garbage;
    robots = [];
    connectedRobots = [];
    emit(AccessRobotLoading());
    var fetchConnectedRobotsResponse =
        await FitchConnectedRobots(instance()).execute(null);
    var response =
        await AccessRobotUsecase(repositry: instance()).execute(garbage);
    response.fold((l) => emit(AccessRobotFailure(l.message)), (r) {
      for (var robot in r) {
        if (!connectedRobots.any((e) => e.robotData.id == robot.id)) {
          robots.add(robot);
        }
      }
    });
    fetchConnectedRobotsResponse
        .fold((l) => emit(AccessRobotFailure(l.message)), (r) {
      for (var robot in r) {
        connectedRobots.add(robot);
      }
    });
    emit(AccessRobotSuccess());
  }
}

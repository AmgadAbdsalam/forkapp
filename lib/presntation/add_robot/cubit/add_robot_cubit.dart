import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import '../../../app/di.dart';
import '../../../domain/use_cases/add_robot_to_database_usecase.dart';

part 'add_robot_state.dart';

class AddRobotCubit extends Cubit<AddRobotState> {
  AddRobotCubit() : super(AddRobotInitial());

  List<RobotRequest> robots = [];
  Future<void> addRobotToDatabase(Robot robot) async {
    emit(AddRobotLoading());
    var response =
        await AddRobotToDatabaseUsecase(repository: instance()).execute(robot);
    response.fold(
      (l) {
        emit(AddRobotFailure(l.message));
      },
      (r) async {
        await accessRobots();
        emit(AddRobotSuccess());
      },
    );
  }

  Future<void> accessRobots() async {
    void garbage;
    robots = [];
    var response =
        await AccessRobotUsecase(repositry: instance()).execute(garbage);
    response.fold((l) => emit(AccessRobotFailure(l.message)), (r) {
      for (var robot in r) {
        robots.add(robot);
      }
      
      emit(AccessRobotSuccess());
    });
  }
}

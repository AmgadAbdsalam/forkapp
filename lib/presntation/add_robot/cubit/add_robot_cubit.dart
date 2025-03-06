import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/access_robot_usecase.dart';
import 'package:responsive/presntation/resources/strings_manager.dart';

import '../../../app/di.dart';

part 'add_robot_state.dart';

class AddRobotCubit extends Cubit<AddRobotState> {
  AddRobotCubit() : super(AddRobotInitial());

  List<RobotRequest> robots = [];
  Future<void> addRobotToDatabase(RobotRequest robot) async {
    String customID = robot.id;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      emit(AddRobotLoading());
      await firestore.collection(AppStrings.robotCollection).doc(customID).set(
          Robot(
                  destination: '',
                  hasError: false,
                  isAvailable: true,
                  isCarry: false,
                  isCharging: false,
                  location: '${robot.x}_${robot.y}',
                  robotData: RobotData(
                      batteryLevel: robot.batteryLevel,
                      dimensions: Dimensions(height: 100, width: 100),
                      macAddress: 'macAddress',
                      maxWeight: 100))
              .toJson());
      await FirebaseDatabase.instance.ref("/robots").remove();
     await accessRobots();
      emit(AddRobotSuccess());
    } catch (e) {
      emit(AddRobotFailure(e.toString()));
    }
  }

  Future<void> accessRobots() async {
    void garbage;
    robots = [];
    var response =
        await AccessRobotUsecase(repositry: instance()).execute(garbage);
    response.fold((l) => emit(AccessRobotFailure(l.message)), (r) {
      robots.add(r);
      emit(AccessRobotSuccess());
    });
  }
}

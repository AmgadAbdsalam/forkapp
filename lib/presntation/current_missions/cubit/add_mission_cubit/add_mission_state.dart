

import 'package:responsive/app/helper_functions.dart';

sealed class AddMissionState  {
}
class AddMissionInitial extends AddMissionState {}
class AddMissionLoading extends AddMissionState {}

class AddMissionFailure extends AddMissionState {
  final String error;

  AddMissionFailure(this.error);
}

class AddMissionSuccess extends AddMissionState {
  GetNearestRobotResponse getNearestRobotResponse;
  AddMissionSuccess(this.getNearestRobotResponse);
}
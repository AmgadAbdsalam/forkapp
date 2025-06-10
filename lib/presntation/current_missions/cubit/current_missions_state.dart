
import 'package:responsive/domain/models/robot_model.dart';

sealed class CurrentMissionsState  {
}
class CurrentMissionsInitial extends CurrentMissionsState {}
class CurrentMissionsLoading extends CurrentMissionsState {}

class CurrentMissionsFailure extends CurrentMissionsState {
  final String error;

  CurrentMissionsFailure(this.error);
}

class CurrentMissionsSuccess extends CurrentMissionsState {
  final List<Robot> missions;

  CurrentMissionsSuccess(this.missions);
}
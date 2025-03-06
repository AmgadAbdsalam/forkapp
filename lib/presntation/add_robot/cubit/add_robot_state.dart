part of 'add_robot_cubit.dart';

sealed class AddRobotState {}

final class AddRobotInitial extends AddRobotState {}

final class AddRobotLoading extends AddRobotState {}

final class AddRobotFailure extends AddRobotState {
  String message;
  AddRobotFailure(this.message);
}

final class AddRobotSuccess extends AddRobotState {}

final class AccessRobotLoading extends AddRobotState {}

final class AccessRobotFailure extends AddRobotState {
  String message;
  AccessRobotFailure(this.message);
}

final class AccessRobotSuccess extends AddRobotState {}

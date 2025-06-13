// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';

Either<Failure, GetNearestRobotResponse> getNearestRobot(List<List<int>> grid,
    List<Robot> availableRobots, int targetX, int targetY) {
  RobotRequest? selectedRobot;
  double cost = double.maxFinite;
  List<RobotRequest> robots = [];

  for (var robot in availableRobots) {
    var robotRequest = RobotRequest.fromRobot(robot);
    robots.add(robotRequest);
  }
  for (var robot in robots) {
    if (cost >
        robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel) {
      cost = robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel;
      selectedRobot = robot;
    }
  }

  if (selectedRobot == null) {
    log('No robot found');
    return left(Failure(0, 'cannot find a robot'));
  }
  log('Selected Robot: ${selectedRobot.id}, Cost: $cost');
  return right(GetNearestRobotResponse(
    cost: cost,
    robotRequest: selectedRobot,
    pathToTarget: selectedRobot.pathTo(grid, targetX, targetY),
  ));
}

class GetNearestRobotResponse {
  RobotRequest robotRequest;
  List<Point> pathToTarget;
  double cost;
  GetNearestRobotResponse({
    required this.robotRequest,
    required this.pathToTarget,
    required this.cost,
  });
}

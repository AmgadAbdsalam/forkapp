// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:responsive/app/di.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/domain/use_cases/fitch_connected_robots.dart';
import 'package:responsive/domain/use_cases/map_data_usecase.dart';

Future<Either<Failure, GetNearestRobotResponse>> getNearestRobot(
    int targetX, int targetY) async {
  String robotId = '';
  RobotRequest? selectedRobot;
  double cost = double.maxFinite;
  List<List<int>> grid = List.generate(100, (index) => List.filled(100, 0));
  List<RobotRequest> robots = [];
  var response = await MapDataUseCase(instance()).execute(null);
  response.fold((falure) {
    return left(Failure(0, 'There was an error in fetching map'));
  }, (r) {
    for (var e in r) {
      grid[e.xAxis][e.yAxis] = e.isFree ? 1 : 0;
    }
  });

  var ronbotsResponse = await FitchConnectedRobots(instance()).execute(null);
  ronbotsResponse.fold(
    (l) {
      return left(l);
    },
    (r) {
      for (var e in r) {
        robots.add(RobotRequest.fromRobot(e));
      }
    },
  );

  for (var robot in robots) {
    if (cost >
        robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel) {
      cost = robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel;
      robotId = robot.id;
    }
  }
  for (var robot in robots) {
    if (robotId == robot.id) {
      selectedRobot = robot;
      break;
    }
  }
  if (selectedRobot == null) {
    return left(Failure(0, 'cannot find a robot'));
  }

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

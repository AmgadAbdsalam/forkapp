import 'package:dartz/dartz.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/domain/use_cases/fitch_connected_robots.dart';
import 'package:responsive/domain/use_cases/map_data_usecase.dart';

Future<Either<Failure, String>> getNearestRobotId(
    int targetX, int targetY) async {
  String robotId = '';
  double cost = double.maxFinite;
  List<List<int>> grid = [];
  List<RobotRequest> robots = [];
  var response = await MapDataUseCase(instance()).execute(null);
  response.fold((falure) {
    return left(Failure(0, 'There was an error in fetching map'));
  }, (map) {
    map.map(
      (e) {
        grid[e.xAxis][e.yAxis] = e.isFree ? 1 : 0;
      },
    );
  });

  var ronbotsResponse = await FitchConnectedRobots(instance()).execute(null);
  ronbotsResponse.fold(
    (l) {
      return left(l);
    },
    (r) {
      r.map(
        (e) => robots.add(e),
      );
    },
  );
  for (var robot in robots) {
    if (cost >
        robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel) {
      cost = robot.distanceTo(grid, targetX, targetY) - .2 * robot.batteryLevel;
      robotId = robot.id;
    }
  }
  return right(robotId);
}
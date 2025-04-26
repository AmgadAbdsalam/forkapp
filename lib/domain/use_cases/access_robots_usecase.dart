

import 'package:dartz/dartz.dart';

import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';
import 'package:collection/collection.dart';

class AccessRobotUsecase implements BaseUseCase<void, List<RobotRequest>> {
  Repository repositry;
  AccessRobotUsecase({
    required this.repositry,
  });
  @override
  Future<Either<Failure, List<RobotRequest>>> execute(input) async {
    return await repositry.robotsAccess();
  }
}

class RobotRequest {
  String id;
  int x;
  int y;
  int batteryLevel;
  RobotRequest({
    required this.id,
    required this.x,
    required this.y,
    required this.batteryLevel,
  });

  //get the distance between the distenation and the robot
  double distanceTo(List<List<int>> grid, int targetX, int targetY) {
    return _aStar(grid, Point(x, y), Point(targetX, targetY));
  }

  double _aStar(List<List<int>> grid, Point start, Point goal) {
    final rows = grid.length;
    final cols = grid[0].length;

    final directions = [
      Point(0, 1),
      Point(1, 0),
      Point(0, -1),
      Point(-1, 0),
    ];

    final gScore = <Point, double>{start: 0};
    final fScore = <Point, double>{start: _heuristic(start, goal)};

    final openSet = HeapPriorityQueue<Point>(
      (a, b) => fScore[a]!.compareTo(fScore[b]!),
    );

    final closedSet = <Point>{}; 
    openSet.add(start);

    while (openSet.isNotEmpty) {
      final current = openSet.removeFirst();

      if (current == goal) {
        return gScore[current]!;
      }
            closedSet.add(current); 

      for (final dir in directions) {
        final neighbor = Point(current.x + dir.x, current.y + dir.y);

        if (neighbor.x < 0 ||
            neighbor.x >= cols ||
            neighbor.y < 0 ||
            neighbor.y >= rows) {
          continue;
        }
        if (grid[neighbor.y][neighbor.x] == 1) continue; // obstacle

        if (closedSet.contains(neighbor))
          continue; // لو النقطة دي خلصناها، تجاهلها

        final tentativeG = gScore[current]! + 1;

        if (tentativeG < (gScore[neighbor] ?? double.infinity)) {
          gScore[neighbor] = tentativeG;
          fScore[neighbor] = tentativeG + _heuristic(neighbor, goal);
          if (!openSet.contains(neighbor)) {
            openSet.add(neighbor);
          }
        }
      }
    }

    return double.infinity; // No path found
  }

  double _heuristic(Point a, Point b) {
    return (a.x - b.x).abs() + (a.y - b.y).abs().toDouble();
  }

  factory RobotRequest.fromJson(Map<String, dynamic> json) {
    return RobotRequest(
      batteryLevel: json['batteryLevel'] ?? 0,
      id: json['id'] ?? '',
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }
}
class Point {
  final int x, y;
  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}


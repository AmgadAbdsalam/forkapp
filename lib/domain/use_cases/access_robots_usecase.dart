// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

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

  factory RobotRequest.fromJson(Map<String, dynamic> json) {
    return RobotRequest(
      batteryLevel: json['batteryLevel'] ?? 0,
      id: json['id'] ?? '',
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
    );
  }
}

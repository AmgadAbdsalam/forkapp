/* 
This use case will be used to add a new robot to the database
The robot data will be sent to the database for storage
Once the robot is added, it can be accessed by other use cases
*/

import 'package:dartz/dartz.dart';

import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class AddRobotToDatabaseUsecase implements BaseUseCase<Robot, String> {
  Repository repository;
  AddRobotToDatabaseUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> execute(Robot input)async {
    return await repository.addRobotToDatabase(input);
  }
}

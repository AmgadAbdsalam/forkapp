// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/access_robot_usecase.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class AddRobotToDatabaseUsecase implements BaseUseCase<RobotRequest, String> {
  Repository repository;
  AddRobotToDatabaseUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> execute(RobotRequest input)async {
    return await repository.addRobotToDatabase(input);
  }
}

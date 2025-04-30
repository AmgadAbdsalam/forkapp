// ignore_for_file: public_member_api_docs, sort_constructors_first
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

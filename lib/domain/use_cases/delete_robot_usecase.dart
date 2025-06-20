import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class DeleteRobotUseCase implements BaseUseCase<String, void> {
  final Repository _repository;

  DeleteRobotUseCase(this._repository);
  @override
  Future<Either<Failure, void>> execute(String input) {
    return _repository.deleteRobot(input);
  }
}
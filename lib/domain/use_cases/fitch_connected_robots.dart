import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class FitchConnectedRobots  implements BaseUseCase<Null, List<RobotRequest>>{
    final Repository _repository;
  FitchConnectedRobots(this._repository);
  @override
  Future<Either<Failure, List<RobotRequest>>> execute(Null input) async {
    
    return await (_repository).getRobots();
  }
}
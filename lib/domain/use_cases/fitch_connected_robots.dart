/* This use case will be used to fetch the list of  all connected robots*/

import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/robot_model.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class FitchConnectedRobots  implements BaseUseCase<Null, List<Robot>>{
    final Repository _repository;
  FitchConnectedRobots(this._repository);
  @override
  Future<Either<Failure, List<Robot>>> execute(Null input) async {
    
    return await (_repository).getRobots();
  }
}
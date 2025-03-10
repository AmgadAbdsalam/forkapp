import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

import '../repository/repository.dart';

class UpdateMapUsecase implements BaseUseCase<List<NodeModel>, String> {
  final Repository
      _repository; 
  UpdateMapUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(List<NodeModel> input) {
    return _repository.updateMap(input);
  }
}

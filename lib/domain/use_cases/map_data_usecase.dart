/* This use case will be used to fetch the map data from the database
It will fetch all nodes and return them as a list of NodeModel */

import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class MapDataUseCase implements BaseUseCase<void, List<NodeModel>> {
  final Repository _repository;

  MapDataUseCase(this._repository);
  @override
  Future<Either<Failure, List<NodeModel>>> execute(void input) async {

    return await _repository.getMap();
  }
}

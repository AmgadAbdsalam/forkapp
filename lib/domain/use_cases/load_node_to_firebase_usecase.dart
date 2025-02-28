import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/node_model.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

import '../repository/repository.dart';

class LoadNodeToFirebaseUsecase implements BaseUseCase<NodeModel, String> {
  final Repository
      _repository; // ıt refer to object from the class that ımplements the abstract class

  LoadNodeToFirebaseUsecase(this._repository);

  @override
  Future<Either<Failure, String>> execute(NodeModel input) {
    return _repository.addNode(input);
  }
}

import 'package:dartz/dartz.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/base_usecase.dart';

class EditNodeUseCase implements BaseUseCase<NodeModel, String> {
  final Repository _repository;

  EditNodeUseCase(this._repository);
  @override
  Future<Either<Failure, String>> execute(NodeModel input) {
    return _repository.editNode(input);
  }
}

/* This use case will be used to edit an existing node in the database
The updated node data will be sent to the database for storage
We put the new node in the place of the old one witch the same id
*/


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

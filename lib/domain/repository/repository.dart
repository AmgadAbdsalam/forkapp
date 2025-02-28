import 'package:responsive/domain/models/node_model.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import 'package:dartz/dartz.dart';

import '../models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> sugnIn(String address, String password);
  Future<Either<Failure, String>> signOut();
  Future<Either<Failure, List<NodeModel>>> getMap();
  Future<Either<Failure,String>> updateMap( List<NodeModel> notesList);
  Future<Either<Failure, String>> addNode(NodeModel node);
}

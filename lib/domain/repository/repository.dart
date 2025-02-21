import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import 'package:dartz/dartz.dart';

import '../models/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> sugnIn(String address, String password);
  void signOut();
}


import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, String> {
  final Repository _repository; // ıt refer to object from the class that ımplements the abstract class

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
      LoginUseCaseInput input) async {
    return await _repository.sugnIn(input.email, input.password);
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}

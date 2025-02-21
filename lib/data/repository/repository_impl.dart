import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responsive/data/mapper.dart';
import 'package:responsive/data/network/error_handler.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/data/network/requests.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final NetworkInfo _networkInfo;
  final RemoteDataSource _remoteDataSourceImpl;
  RepositoryImpl(this._networkInfo, this._remoteDataSourceImpl);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSourceImpl.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? "business error message"));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sugnIn(
      String address, String password) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: address, password: password);
      return const Right('Success');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        return Left(Failure(0, 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        return Left(Failure(1, 'Wrong password provided for that user.'));
      }
    }
    return Left(Failure(2, 'error!! please try again'));
  }
  
  @override
 void signOut() async {
  await FirebaseAuth.instance.signOut();
}

}



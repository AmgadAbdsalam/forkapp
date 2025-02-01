import 'package:dartz/dartz.dart';
import 'package:responsive/data/mapper.dart';
import 'package:responsive/data/network/error_handler.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/data/network/requests.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/repository/repository.dart';

import '../data_source/remote_data_source.dart';
import '../network/network_info.dart';

class RepositoryImpl  implements Repository{
 final NetworkInfo _networkInfo;
 final RemoteDataSource _remoteDataSourceImpl;
 RepositoryImpl(this._networkInfo,this._remoteDataSourceImpl);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest)async {
   if (await _networkInfo.isConnected){
     try{
       final response= await _remoteDataSourceImpl.login(loginRequest);
       if(response.status==ApiInternalStatus.SUCCESS){
         // success
         // return either right
         // return data
         return Right(response.toDomain());
       }else{
         // failure --return business error
         // return either left
         return Left(Failure(ApiInternalStatus.FAILURE , response.message ?? "business error message"));
       }
     }catch(error){
     return  Left(ErrorHandler.handle(error).failure);
     }

   }else{
     // return internet connection error
     // return either left
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

}
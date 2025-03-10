import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:responsive/app/constant.dart';
import 'package:responsive/data/mapper.dart';
import 'package:responsive/data/network/error_handler.dart';
import 'package:responsive/data/network/failure.dart';
import 'package:responsive/data/network/requests.dart';
import 'package:responsive/data/respones/nodes_response.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/models/node_model.dart';
import 'package:responsive/domain/repository/repository.dart';
import 'package:responsive/domain/use_cases/access_robot_usecase.dart';

import '../../domain/models/robot_model.dart';
import '../../presntation/resources/strings_manager.dart';
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
      return const Right(Constant.success);
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
  Future<Either<Failure, String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(Constant.success);
    } catch (e) {
      return Left(Failure(0, 'error!! please try again'));
    }
  }

  @override
  Future<Either<Failure, List<NodeModel>>> getMap() async {
    if (await _networkInfo.isConnected) {
      try {
        List<NodeModel> nodes = await _fetchMapData();

        return Right(nodes);
      } catch (e) {
        return Left(Failure(0, "Error fetching map data: $e"));
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<List<NodeModel>> _fetchMapData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(Constant.mapCollection)
        .doc(Constant.mapDoc) // ID الخاص بالخريطة
        .get();

    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    List<dynamic> nodeList = data['nodes'] ?? [];
    return nodeList.map((node) => NodeResponse.fromMap(node)).toList();
  }

  @override
  Future<Either<Failure, String>> addNode(NodeModel node) async {
    if (await _networkInfo.isConnected) {
      try {
        List<NodeModel> nodes = await _fetchMapData();

        nodes.add(NodeResponse.fromMap(node.toMap()));
        List<Map<String, dynamic>> nodesData =
            nodes.map((node) => node.toMap()).toList();
        await FirebaseFirestore.instance
            .collection(Constant.mapCollection)
            .doc(Constant.mapDoc)
            .update({"nodes": FieldValue.arrayUnion(nodesData)});
        return const Right(Constant.success);
      } catch (e) {
        return Left(Failure(0, "Error loading node: $e"));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateMap(List<NodeModel> notesList) async {
    if (await _networkInfo.isConnected) {
      try {
        List<Map<String, dynamic>> nodesData =
            notesList.map((node) => node.toMap()).toList();

        await FirebaseFirestore.instance
            .collection(Constant.mapCollection)
            .doc(Constant.mapDoc)
            .update({"nodes": FieldValue.arrayUnion(nodesData)});
        return const Right(Constant.success);
      } catch (e) {
        return Left(Failure(0, "Error loading node: $e"));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RobotRequest>> robotAccess() async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("/robots"); // حدد المسار فقط

      DataSnapshot snapshot = await ref.get();
      Map<String, dynamic> data =
          Map<String, dynamic>.from(snapshot.value as Map);
      RobotRequest robot = RobotRequest.fromJson(data);
      return Right(robot);
    } catch (e) {
      return Left(
          Failure(1, 'there wase an error in cathing robots requests: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> addRobotToDatabase(RobotRequest robot) async {
    String customID = robot.id;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection(AppStrings.robotCollection).doc(customID).set(
          Robot(
                  destination: '',
                  hasError: false,
                  isAvailable: true,
                  isCarry: false,
                  isCharging: false,
                  location: '${robot.x}_${robot.y}',
                  robotData: RobotData(
                      batteryLevel: robot.batteryLevel,
                      dimensions: Dimensions(height: 100, width: 100),
                      macAddress: 'macAddress',
                      maxWeight: 100))
              .toJson());
      await FirebaseDatabase.instance.ref("/robots").remove();
      return const Right(Constant.success);
    } catch (e) {
      return Left(Failure(0, e.toString()));
    }
  }
}

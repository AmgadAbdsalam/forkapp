// ignore_for_file: public_member_api_docs, sort_constructors_first
// onboarding models

import 'package:cloud_firestore/cloud_firestore.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

// login models

class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

//login state model
class LoginStateModel {
  final bool isPasswordValid;
  final bool isUsernameValid;
  final bool isPasswordAndUserNameValid;
  final bool isUserSuccessfulLogin;

  LoginStateModel(
    this.isPasswordValid,
    this.isUsernameValid,
    this.isPasswordAndUserNameValid,
    this.isUserSuccessfulLogin,
  );

  LoginStateModel copyWith({
    bool? isPasswordValid,
    bool? isUsernameValid,
    bool? isPasswordAndUserNameValid,
    bool? isUserSuccessfulLogin,
  }) {
    return LoginStateModel(
      isPasswordValid ?? this.isPasswordValid,
      isUsernameValid ?? this.isUsernameValid,
      isPasswordAndUserNameValid ?? this.isPasswordAndUserNameValid,
      isUserSuccessfulLogin ?? this.isUserSuccessfulLogin,
    );
  }
}

// config state model
class ConfigStateModel {
  final bool isWidthValid;
  final bool isLengthValid;
  final bool isWidthAndLengthValid;

  ConfigStateModel(
    this.isWidthValid,
    this.isLengthValid,
    this.isWidthAndLengthValid,
  );

  ConfigStateModel copyWith({
    bool? isWidthValid,
    bool? isLengthValid,
    bool? isWidthAndLengthValid,
  }) {
    return ConfigStateModel(
      isWidthValid ?? this.isWidthValid,
      isLengthValid ?? this.isLengthValid,
      isWidthAndLengthValid ?? this.isWidthAndLengthValid,
    );
  }
}
/////

//node model
class NodeModel {
  final int nodeId;
  final Timestamp updatedTime;
  final int xAxis;
  final int yAxis;
  final bool isFree;
  final bool isCharged;
  final bool isBlocked;



  NodeModel({
    required this.nodeId,
    required this.updatedTime,
    required this.xAxis,
    required this.yAxis,
    required this.isFree,
    required this.isCharged,
    required this.isBlocked,
  });

  // copy with
  NodeModel copyWith(
      {int? nodeId,
      String? nodeType,
      Timestamp? updatedTime,
      int? xAxis,
      int? yAxis,
      bool? isFree,
        bool?isCharged,
        bool?isBlocked,
      }) {
    return NodeModel(
        nodeId: nodeId ?? this.nodeId,
        updatedTime: updatedTime ?? this.updatedTime,
        xAxis: xAxis ?? this.xAxis,
        yAxis: yAxis ?? this.yAxis,
      isFree: isFree??this.isFree,
      isCharged: isCharged??this.isCharged,
      isBlocked: isBlocked??this.isBlocked,
    );

  }

  Map<String, dynamic> toMap() {
    return {
      'id': nodeId,
      'updated_at': updatedTime,
      'x': xAxis,
      'y': yAxis,
      'isFree':isFree,
      'isCharged':isCharged,
      'isBlocked':isBlocked,

    };
  }
}

// home state Model
// class HomeStateModel {
//   final List<NodeModel> nodes;
//   final bool isFree;
//   final bool isCharged;
//   final bool isBlocked;
//   HomeStateModel(this.nodes, this.isFree, this.isCharged, this.isBlocked);
//   HomeStateModel copyWith({List<NodeModel>? nodes,bool? isFree,bool? isCharged,bool? isBlocked}){
//     return HomeStateModel(
//       nodes ?? this.nodes,
//       isFree ?? this.isFree,
//       isCharged ??this.isCharged,
//       isBlocked ?? this.isBlocked,
//     );
//   }
// }

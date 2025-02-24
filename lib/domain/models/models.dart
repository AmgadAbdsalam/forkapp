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

  LoginStateModel(this.isPasswordValid, this.isUsernameValid,
      this.isPasswordAndUserNameValid,this.isUserSuccessfulLogin,);

  LoginStateModel copyWith({bool? isPasswordValid,
    bool? isUsernameValid,
    bool? isPasswordAndUserNameValid,
    bool? isUserSuccessfulLogin,


  }) {
    return LoginStateModel(
        isPasswordValid ?? this.isPasswordValid,
        isUsernameValid ?? this.isUsernameValid,
        isPasswordAndUserNameValid ??this.isPasswordAndUserNameValid,
      isUserSuccessfulLogin ??this.isUserSuccessfulLogin,


    );
  }
}


//man models

//node model
class NodeModel {
  String nodeId;
  List<String> neighborsList;
  String nodeType;
  Timestamp updatedTime;
  int xAxis;
  int yAxis;
  NodeModel({
    required this.nodeId,
    required this.neighborsList,
    required this.nodeType,
    required this.updatedTime,
    required this.xAxis,
    required this.yAxis,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': nodeId,
      'neighbors': neighborsList,
      'type': nodeType,
      'updated_at': updatedTime,
      'x': xAxis,
      'y': yAxis,
    };
  }

}

// ignore_for_file: public_member_api_docs, sort_constructors_first
// onboarding models

import 'package:cloud_firestore/cloud_firestore.dart';

class NodeModel {
  String nodeId;
  String nodeType;
  Timestamp updatedTime;
  int xAxis;
  int yAxis;
  NodeModel({
    required this.nodeId,
    required this.nodeType,
    required this.updatedTime,
    required this.xAxis,
    required this.yAxis,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': nodeId,
      'type': nodeType,
      'updated_at': updatedTime,
      'x': xAxis,
      'y': yAxis,
    };
  }

}

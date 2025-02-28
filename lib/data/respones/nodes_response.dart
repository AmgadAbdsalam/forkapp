import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive/domain/models/node_model.dart';

class NodeResponse extends NodeModel {
  String id;
  String type;
  Timestamp updatedAt;
  int x;
  int y;

  NodeResponse({
    required this.id,
    required this.type,
    required this.updatedAt,
    required this.x,
    required this.y,
  }) : super(
            nodeId: id,
            nodeType: type,
            updatedTime: updatedAt,
            xAxis: x,
            yAxis: y);

  factory NodeResponse.fromMap(Map<String, dynamic> map) {
    return NodeResponse(
      id: map['id'] ?? '',
      type: map['type'] ?? '',
      updatedAt: (map['updated_at'] as Timestamp),
      x: map['x'] ?? 0,
      y: map['y'] ?? 0,
    );
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive/domain/models/models.dart';

class NodeResponse extends NodeModel {
  String id;
  List<String> neighbors;
  String type;
  Timestamp updatedAt;
  int x;
  int y;

  NodeResponse({
    required this.id,
    required this.neighbors,
    required this.type,
    required this.updatedAt,
    required this.x,
    required this.y,
  }) : super(
            nodeId: id,
            neighborsList: neighbors,
            nodeType: type,
            updatedTime: updatedAt,
            xAxis: x,
            yAxis: y);

  factory NodeResponse.fromMap(Map<String, dynamic> map) {
    return NodeResponse(
      id: map['id'] ?? '',
      neighbors: List<String>.from(map['neighbors'] ?? []),
      type: map['type'] ?? '',
      updatedAt: (map['updated_at'] as Timestamp),
      x: map['x'] ?? 0,
      y: map['y'] ?? 0,
    );
  }


}

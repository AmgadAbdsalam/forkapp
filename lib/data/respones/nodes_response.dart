import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive/domain/models/models.dart';

class NodeResponse extends NodeModel {
final  int id;
final Timestamp updatedAt;
final  int x;
 final int y;
 final bool free;
 final bool charged;
 final bool blocked;

  NodeResponse({
    required this.id,
    required this.updatedAt,
    required this.x,
    required this.y,
    required this.free,
    required this.charged,
    required this.blocked

  }) : super(
            nodeId: id,
            updatedTime: updatedAt,
            xAxis: x,
            yAxis: y,
    isFree: free,
    isCharged: charged,
    isBlocked: blocked,
  );

  factory NodeResponse.fromMap(Map<String, dynamic> map) {
    return NodeResponse(
      id: map['id'] ?? '',
      updatedAt: (map['updated_at'] as Timestamp),
      x: map['x'] ?? 0,
      y: map['y'] ?? 0,
      free: map['isFree']??true,
      charged: map['isCharged']??false,
      blocked: map['isBlocked']??false,
    );
  }


}

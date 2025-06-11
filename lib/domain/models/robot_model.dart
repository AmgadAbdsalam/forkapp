// ignore_for_file: public_member_api_docs, sort_constructors_first
class Robot {
  String destination;
  bool hasError;
  bool isAvailable;
  bool isCarry;
  bool isCharging;
  String location;
  RobotData robotData;

  Robot({
    required this.destination,
    required this.hasError,
    required this.isAvailable,
    required this.isCarry,
    required this.isCharging,
    required this.location,
    required this.robotData,
  });

  factory Robot.fromJson(Map<String, dynamic> json) {
    return Robot(
      destination: json['destination'] ?? '',
      hasError: json['hasError'] ?? false,
      isAvailable: json['isAvailable'] ?? false,
      isCarry: json['isCarry'] ?? false,
      isCharging: json['isCharging'] ?? false,
      location: json['location'] ?? '',
      robotData: RobotData.fromJson(json['robotData'] ?? {}),
    );
  }

  factory Robot.fromMap(Map<String, dynamic> map) {
    return Robot(
      destination: map['destination'] ?? '',
      hasError: map['hasError'] ?? false,
      isAvailable: map['isAvailable'] ?? false,
      isCarry: map['isCarry'] ?? false,
      isCharging: map['isCharging'] ?? false,
      location: map['location'] ?? '',
      robotData: RobotData.fromJson(map['robotData'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'hasError': hasError,
      'isAvailable': isAvailable,
      'isCarry': isCarry,
      'isCharging': isCharging,
      'location': location,
      'robotData': robotData.toJson(),
    };
  }

  @override
  String toString() {
    return 'Robot(destination: $destination, hasError: $hasError, isAvailable: $isAvailable, isCarry: $isCarry, isCharging: $isCharging, location: $location)';
  }
}

class RobotData {
  int batteryLevel;
  Dimensions dimensions;
  String id;
  int maxWeight;

  RobotData({
    required this.batteryLevel,
    required this.dimensions,
    required this.id,
    required this.maxWeight,
  });

  factory RobotData.fromJson(Map<String, dynamic> json) {
    return RobotData(
      batteryLevel: json['battryLevel'] ?? 0,
      dimensions: Dimensions.fromJson(json['dimensions'] ?? {}),
      id: json['id'] ?? '',
      maxWeight: json['maxWeight'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'battryLevel': batteryLevel,
      'dimensions': dimensions.toJson(),
      'mac_address': id,
      'maxWeight': maxWeight,
    };
  }

  @override
  String toString() {
    return 'RobotData(batteryLevel: $batteryLevel, dimensions: $dimensions, id: $id, maxWeight: $maxWeight)';
  }
}

class Dimensions {
  int height;
  int width;

  Dimensions({required this.height, required this.width});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      height: json['hieght'] ?? 0,
      width: json['width'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hieght': height,
      'width': width,
    };
  }
}

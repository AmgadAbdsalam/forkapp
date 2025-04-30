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
      id: json['mac_address'] ?? '',
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

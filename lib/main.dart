import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/application_class.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/use_cases/access_robots_usecase.dart';
import 'package:responsive/domain/use_cases/fitch_connected_robots.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var response = await FitchConnectedRobots(instance()).execute(null);

  List<RobotRequest> robots = [];
  response.fold((l) => print(l.message), (robotsList) {
    for (var robot in robotsList) {
      robots.add(robot);
    }
  });
  var grid = [
    [0, 0, 0, 0, 0],
    [0, 1, 1, 1, 0],
    [0, 1, 1, 1, 0],
    [0, 1, 1, 1, 0],
    [0, 0, 0, 0, 0],
  ];
  for (var i =0; i < 3; i++) {
    double x = robots[i].distanceTo(grid, 0, 0);
    log('distance from ${robots[i].id} to target: $x');
  }
  runApp(ProviderScope(
      child: DevicePreview(enabled: true, builder: (context) => MyApp())));
}

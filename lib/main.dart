import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/application_class.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/app/helper_functions.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var response = await getNearestRobot(3, 3);
  response.fold(
    (l) {
      print(l.message);
    },
    (r) {
      print('id: ${r.robotRequest.id}');
      print('battery: ${r.robotRequest.batteryLevel}');
      print('x: ${r.robotRequest.x}');
      print('y: ${r.robotRequest.y}');
      print('cost: ${r.cost}');
      print(r.pathToTarget);
    },
  );
  runApp(ProviderScope(
      child: MyApp()));
}

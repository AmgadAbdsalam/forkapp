import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/application_class.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/domain/use_cases/edit_node_usecase.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var x = await EditNodeUsecase(instance()).execute(NodeModel(
      nodeId: 2,
      updatedTime: Timestamp.now(),
      xAxis: 22,
      yAxis: 22,
      isFree: true,
      isCharged: false,
      isBlocked: false));
  x.fold((l) => print(l.message), (r) => print(r));
  runApp(ProviderScope(child: MyApp()));
}

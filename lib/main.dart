import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app/application_class.dart';
import 'app/di.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
 await initAppModule();
  runApp(ProviderScope(child: MyApp()));
}

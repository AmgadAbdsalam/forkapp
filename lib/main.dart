import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/application_class.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

signUp() async {
  try {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'khaled@gmail.com',
      password: '12345678',
    );

    log('User created: ${userCredential.user!.email}');
  } on FirebaseAuthException catch (e) {
    log('FirebaseAuthException: ${e.code} - ${e.message}');
  } catch (e) {
    log('Error: $e');
  }
}


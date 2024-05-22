import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/firebase_options.dart';

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

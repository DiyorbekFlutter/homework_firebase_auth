import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homework_firebase_auth/pages/home_page.dart';
import 'package:homework_firebase_auth/pages/onboarding.dart';
import 'package:homework_firebase_auth/setup.dart';

void main() async {
  await setup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomePage(user: snapshot.data as User);
        } else {
          return const Onboarding();
        }
      },
    );
  }
}


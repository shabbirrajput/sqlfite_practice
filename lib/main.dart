import 'package:flutter/material.dart';
import 'package:sqlite_practice/auth/sign_up.dart';
import 'package:sqlite_practice/db/navigator_key.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      navigatorKey: NavigatorKey.navigatorKey,
      home: const SignUp(),
    );
  }
}

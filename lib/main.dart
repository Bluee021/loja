import 'package:ecommerce/views/home/home.dart';
import 'package:ecommerce/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'E-Commerce',
        theme: ThemeData(
            colorScheme:
                ThemeData().colorScheme.copyWith(primary: Color(0xff33907C))),
        home: SafeArea(child: Login()));
  }
}

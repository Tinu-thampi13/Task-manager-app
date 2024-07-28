import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/Authentication/authentication.dart';
import 'package:task_management_app/Authentication/login.dart';
import 'package:task_management_app/Authentication/signup.dart';
import 'package:task_management_app/Screens/homescreen.dart';
import 'package:task_management_app/db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: AuthMethod().isUserLoggedIn() != null
          ? const HomePage()
          : const LoginScreen(),
    );
  }
}

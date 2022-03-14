import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebatecnica/screens/home_screen/home_screen.dart';
import 'package:pruebatecnica/screens/insert_screen/insert_screen.dart';
import 'package:pruebatecnica/screens/update_screen/update_screen.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => const HomeScreen(),
        '/insert': (_) => const InsertScreen(),
        '/edit': (_) => const UpdateScreen(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:searcharea/view/splash/splash_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //
      home: SplashView(),
    );
  }
}

import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
             "어디있지?" ,
             style: TextStyle(
              fontSize: 20,
              color: Colors.white
             ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSplashScreen extends StatelessWidget {
  const CustomSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use your custom image as the background of the splash screen
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/resources/assets/images/fleet01.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

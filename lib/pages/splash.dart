import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phenom2025/pages/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // HIDE TOP AND BOTTOM SYSTEM UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // SPLASH SCREEN TIMER
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => Home(),
          // builder: (_) => Admin(),
        ),
      );
    });
  }

  // RE-SHOW TOP AND BOTTOM SYSTEM UI
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff510D84),
              Color(0xff25073D),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // Centering the container if needed
          child: SizedBox(
            width: 250,
            height: 250,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover, // Ensures the image covers the box
            ),
          ),
        ),
      ),
    );
  }
}

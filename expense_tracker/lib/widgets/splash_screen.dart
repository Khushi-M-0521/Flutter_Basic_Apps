import 'dart:async';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Expenses())));
  }

  @override
  Widget build(BuildContext context) {
    final isdarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assests/images/splash.png',
          scale: 0.5,
          color: isdarkMode?const Color.fromARGB(185, 255, 255, 255):null,
        ),
      ),
    );
  }
}

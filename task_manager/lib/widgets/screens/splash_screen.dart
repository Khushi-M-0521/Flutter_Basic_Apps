import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager/widgets/screens/tasks_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreen();
  }

}

class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TasksScreen())));
  }

  @override
  Widget build(BuildContext context) {
    final isdarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assests/images/TaskManagerIcon.png',
          width: 300,
          color: isdarkMode?const Color.fromARGB(185, 255, 255, 255):null,
        ),
      ),
    );
  }

}
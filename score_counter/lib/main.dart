import 'package:flutter/material.dart';
import 'package:score_counter/data/storage.dart';
import 'package:score_counter/modal/constants.dart';
import 'package:score_counter/screens/home_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const ScoreCounter());
}

class ScoreCounter extends StatelessWidget{
  const ScoreCounter({super.key});

  @override
  Widget build(BuildContext context) {
   
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kLightTheme,
      cardTheme:const CardTheme().copyWith(
        elevation: 10,
      )
    ),
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkTheme,
      cardTheme:const CardTheme().copyWith(
        elevation: 10,
      )
    ),
    home: const HomeScreen(),
   );
  }

  
}
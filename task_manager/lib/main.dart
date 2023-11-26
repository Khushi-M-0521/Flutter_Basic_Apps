import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/widgets/screens/splash_screen.dart';

late ObjectBox objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();
  
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData.light().copyWith(
        colorScheme: kLightColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kLightColorScheme.primary,
          foregroundColor: kLightColorScheme.onPrimary,
          titleTextStyle:const  TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
        textTheme: const TextTheme().copyWith(
          titleMedium: TextStyle(color: kLightColorScheme.onSecondaryContainer,fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: kLightColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 20),
          bodyLarge: TextStyle(color: kLightColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 17),
          bodyMedium: TextStyle(color: kLightColorScheme.onSecondaryContainer),
          bodySmall: TextStyle(color: kLightColorScheme.onSecondaryContainer),
          labelLarge: TextStyle(color: kLightColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 16),
        ),
        cardTheme:const CardTheme().copyWith(elevation: 10),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          //backgroundColor: kDarkColorScheme.primary,
          backgroundColor: kDarkColorScheme.surfaceTint,
          foregroundColor: kDarkColorScheme.onPrimary,
          titleTextStyle: TextStyle(color: kDarkColorScheme.onPrimary,fontWeight: FontWeight.bold,fontSize: 24),
        ),
        textTheme: const TextTheme().copyWith(
          titleMedium: TextStyle(color: kDarkColorScheme.onSecondaryContainer,fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(color: kDarkColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 20),
          bodyLarge: TextStyle(color: kDarkColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 17),
          bodyMedium: TextStyle(color: kDarkColorScheme.onSecondaryContainer,),
          bodySmall: TextStyle(color: kDarkColorScheme.onSecondaryContainer),
          labelLarge: TextStyle(color: kDarkColorScheme.onSecondaryContainer,fontWeight: FontWeight.bold,fontSize: 16),
        ),
        cardTheme:const CardTheme().copyWith(elevation: 10,surfaceTintColor: const Color.fromARGB(255, 45, 14, 243)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

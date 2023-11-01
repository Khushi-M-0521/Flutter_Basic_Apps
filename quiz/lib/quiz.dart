import 'package:flutter/material.dart';
import 'package:quiz/data/questionList.dart';
import 'package:quiz/first_frame.dart';
import 'package:quiz/models/questions.dart';
import 'package:quiz/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  //Widget? activeScreen;

  List<String> selectedAnswer=[];
  var activeScreen = 'first-screen';

  // @override
  // void initState() { //used for general iniatisation
  //   activeScreen = FirstFrame(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      //activeSceen = const Questions();
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswer.add(answer);
    if (selectedAnswer.length==questions.length){
      setState(() {
        //selectedAnswer=[];
        activeScreen='result-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // final screenWidget=(activeScreen == 'first-screen')
    //              ? FirstFrame(switchScreen)
    //              : const Questions();

    Widget screenWidget=FirstFrame(switchScreen);
    if(activeScreen == 'question-screen'){
      selectedAnswer=[];
      screenWidget= Questions(chooseAnswer);
    }

    if(activeScreen == 'result-screen'){
      screenWidget= ResultScreen(chosenAnswers: selectedAnswer,switchScreen: switchScreen);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 3, 94, 231),
                Color.fromARGB(255, 66, 133, 234)
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: screenWidget,
          //child: Center(
            // child: (activeScreen == 'first-screen')
            //     ? FirstFrame(switchScreen)
            //     : const Questions(),
          //  child: screenWidget,
          //),
        ),
      ),
    );
  }
}

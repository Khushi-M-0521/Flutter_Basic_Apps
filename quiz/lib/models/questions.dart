import 'package:flutter/material.dart';
import 'package:quiz/answer_button.dart';
import 'package:quiz/sytle_text.dart';
import 'package:quiz/data/questionList.dart';

class Questions extends StatefulWidget{
  const Questions(this.onSelectAnswer,{super.key});

  final void Function(String answer) onSelectAnswer; 

  @override
  State<Questions> createState() {
    return _QuestionsState();
  }

}

class _QuestionsState extends State<Questions>{
  var currentQuestionIndex=0;

  void answerQuestion(String answer){
    widget.onSelectAnswer(answer);
    setState(() {
      currentQuestionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion=questions[currentQuestionIndex];

    return  SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: StyleText(currentQuestion.text, 30)),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffleAnswers().map((answer) {
              return AnswerButton(answer, (){
                answerQuestion(answer);
              });
            }),
            // AnswerButton(currentQuestion.answers[0], () { }),
            // AnswerButton(currentQuestion.answers[1], () { }),
            // AnswerButton(currentQuestion.answers[2], () { }),
            // AnswerButton(currentQuestion.answers[3], () { }),
            ],
        ),
      ),
    );
  }

}
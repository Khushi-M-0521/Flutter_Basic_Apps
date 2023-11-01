import 'package:flutter/material.dart';
import 'package:quiz/data/questionList.dart';
import 'package:quiz/summary.dart';
import 'package:quiz/sytle_text.dart';

class ResultScreen extends StatelessWidget{
  const ResultScreen({super.key, required this.chosenAnswers, required this.switchScreen});

  final List<String> chosenAnswers;
  final void Function() switchScreen;

  List<Map<String, Object>> getSummaryData(){
    final List<Map<String, Object>> summary=[];

    for (int i=0;i<questions.length;i++){
        summary.add({
          'question_index': i+1,
          'question': questions[i].text,
          'correct_answer':questions[i].answers[0],
          'user_answer':chosenAnswers[i]
        });
      
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData=getSummaryData();
    final totalQuestions=questions.length;
    final List<bool> correctData=summaryData.map((data){
      return data['correct_answer'].toString()==data['user_answer'].toString();
    }).toList();
    final numCorrectData=correctData.where((data) {
      return data==true;
    });

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyleText('You answered ${numCorrectData.length} out of $totalQuestions questions correctly! ', 35),
            const SizedBox(height: 30,),
            ResSummary(getSummaryData(),correctData),
            const SizedBox(height: 30,),
            OutlinedButton.icon(
              onPressed: switchScreen, 
              icon: const Icon(Icons.refresh,color: Colors.amber,), 
              label: const StyleText('Restart Quiz', 20))
            
          ],
        ),
      ),
    );
  }

}
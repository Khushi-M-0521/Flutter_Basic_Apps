import 'package:flutter/material.dart';
import 'package:quiz/sytle_text.dart';

void startQuiz() {}

class FirstFrame extends StatelessWidget {
  const FirstFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assests/images/quiz-logo.png',
          width: 300,
        ),
        const SizedBox(
          height: 50,
        ),
        const StyleText('Morse Learn!', 28),
        const SizedBox(
          height: 20,
        ),
        const RawMaterialButton(
          onPressed: startQuiz,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(255, 101, 149, 237)),
            borderRadius: BorderRadius.all(
              Radius.circular(2),
            ),
          ),
          child: StyleText('  Start Quiz  ', 20),
        ),
      ],
    );
  }
}

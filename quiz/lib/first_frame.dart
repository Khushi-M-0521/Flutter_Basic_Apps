import 'package:flutter/material.dart';
import 'package:quiz/sytle_text.dart';

void startQuiz() {}

class FirstFrame extends StatelessWidget {
  const FirstFrame(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset(
          //     'assests/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          Image.asset(
              'assests/images/quiz-logo.png',
              width: 300,
              color: const Color.fromARGB(174, 255, 214, 64),
            ),
          const SizedBox(
            height: 50,
          ),
          const StyleText('Morse Learn!', 28),
          const SizedBox(
            height: 20,
          ),
          //const RawMaterialButton(
          //  onPressed: startQuiz,
          //  shape: RoundedRectangleBorder(
          //    side: BorderSide(color: Color.fromARGB(255, 101, 149, 237)),
          //    borderRadius: BorderRadius.all(
          //      Radius.circular(2),
          //    ),
          //  ),
          //  child: StyleText('  Start Quiz  ', 20),
          //),
          OutlinedButton.icon(
            onPressed: startQuiz,
            icon: const Icon(Icons.arrow_right_alt, color: Colors.amberAccent,),
            label: const StyleText('  Start Quiz  ', 20),
          )
        ],
      ),
    );
  }
}

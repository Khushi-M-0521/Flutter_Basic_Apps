import 'package:flutter/material.dart';
import 'package:quiz/sytle_text.dart';

class AnswerButton extends StatelessWidget {
  final String answerText;
  final void Function() onTap;
  const AnswerButton(this.answerText, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 3, 27, 144),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const  EdgeInsets.symmetric(vertical: 5,horizontal: 50),
      ),
      child: StyleText(answerText, 20),
    );
  }
}

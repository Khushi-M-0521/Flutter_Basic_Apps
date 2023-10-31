import 'package:flutter/material.dart';
import 'package:quiz/first_frame.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child:const Center(child:FirstFrame()),
    );
  }
}

//import 'package:dice/styled_text.dart';
import 'package:dice/dice_roller.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
   const GradientContainer({super.key, required this.clr});
  //GradientContainer({key}):super(key:key);

  final List<Color> clr;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: clr,
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: const Center(
        child: DiceRoller(),
      ),
    );
  }
}

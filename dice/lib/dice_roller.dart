import 'package:dice/styled_text.dart';
import 'package:flutter/material.dart';
import 'dart:math';

final randomizer=Random(); 

class DiceRoller extends StatefulWidget{
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller>{
  
  var currDiceRoll=3;

  void rollDice() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Rolled!!")));
    setState(() {
      currDiceRoll = randomizer.nextInt(6)+1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assests/dice-images/dice-$currDiceRoll.png",
              width: 300,
            ),
            const SizedBox(height: 20,),//an alternative to padding
            TextButton(
              onPressed: rollDice,
              //style:TextButton.styleFrom(padding: const EdgeInsets.only(top: 20)),
              child: const StyledText('Roll Dice'),
            )
          ],
        );
  }

}
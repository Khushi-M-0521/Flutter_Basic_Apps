import 'package:flutter/material.dart';

//var text='Hello World!!';
//const text='Hello World!!'; compiled time constatnt
//final text='Hello World!!'; NOT compiled time constatnt but can be set once

class StyledText extends StatelessWidget{
  //StyledText(String text, {super.key}):txt=text;
  const StyledText(this.txt, {super.key});
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(txt,
          style: const TextStyle(color: Colors.white, 
          fontSize: 28),
        );
  }
}
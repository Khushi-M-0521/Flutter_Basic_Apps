import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  const StyleText(this.txt, this.font, {super.key});

  final String txt;
  final double font;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
          color: Colors.orangeAccent, 
          fontSize: font,
          fontWeight: FontWeight.bold),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText extends StatelessWidget {
  const StyleText(this.txt, this.font, {super.key});

  final String txt;
  final double font;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      // style: TextStyle(
      //     color: Colors.orangeAccent,
      //     fontSize: font,
      //     fontWeight: FontWeight.bold),
      style: GoogleFonts.kalam(
        color: Colors.orangeAccent,
        fontSize: font,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:dice/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
     const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientContainer(clr:  [
                Color.fromARGB(255, 28, 27, 27),
                Color.fromARGB(255, 58, 57, 57),
              ]),
      ),
    ),
  );
}


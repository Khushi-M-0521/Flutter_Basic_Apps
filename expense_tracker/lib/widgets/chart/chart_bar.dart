import 'package:flutter/material.dart';

// ignore: camel_case_types
class Chart_Bar extends StatelessWidget{
  const Chart_Bar({super.key,required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FractionallySizedBox(
        heightFactor: fill,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),) 
      );
  }

}
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Chart_Bar extends StatelessWidget {
  const Chart_Bar({super.key, required this.fill, required this.amt});

  final double fill;
  final double amt;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: FractionallySizedBox(
        heightFactor: fill < 0.25 ? 0.25 : fill,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
            color: Theme.of(context).colorScheme.secondary,
          ),
          child: Center(
            child: Text(
              '₹ ${amt.toStringAsFixed(2)}',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ),
      ),
    ));
  }
}

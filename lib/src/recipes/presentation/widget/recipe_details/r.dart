import 'package:flutter/material.dart';

class Ingredientde extends StatelessWidget {
  final String ingredient;
  final String ingredientt;
  final String ingredienttt;
  final String ingredientttt;
  const Ingredientde({
    Key? key,
    required this.ingredient,
    required this.ingredientt,
    required this.ingredienttt,
    required this.ingredientttt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ingredient + ingredientt + ingredienttt + ingredientttt,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}

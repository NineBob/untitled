import 'package:flutter/material.dart';

class IngredientCardWidget extends StatelessWidget {
  final String ingredient;
  final String ingredientt;
  final String ingredienttt;
  const IngredientCardWidget({
    Key? key,
    required this.ingredient,
    required this.ingredientt,
    required this.ingredienttt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.3),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        ingredient+' '+ingredientt+' '+ingredienttt,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

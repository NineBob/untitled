// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:untitled/src/recipes/presentation/widget/recipe_details/ingredient_card_widget.dart';

class IngredientsCardList extends StatelessWidget {
  final Recipe recipe;
  final Duration delayTime;
  final Duration slidingDuration;
  final double count;
  final AnimationController ingredientController;
  const IngredientsCardList({
    Key? key,
    required this.recipe,
    required this.delayTime,
    required this.slidingDuration,
    required this.count,
    required this.ingredientController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: recipe.ingredients.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var ingredient = recipe.ingredients[index];
          String k = ingredient['amount'];
          double doubleValue = double.parse(k);
          double kk = double.parse(k);
          doubleValue=doubleValue*count;
          String bv='';
          if(ingredient['unit']=='หัว'&&doubleValue%1!=0){bv=doubleValue.toStringAsFixed(1);}
          else{bv=doubleValue.toStringAsFixed(0);}
          if(ingredient['unit']=='ฟอง'){doubleValue= doubleValue.round().toDouble();}
          return IngredientCardWidget(
            ingredient: ingredient['name'],
            ingredientt: bv ,
            ingredienttt:  ingredient['unit'],// Assuming 'name' is the key for the ingredient name
             // Assuming 'unit' is the key for the ingredient unit
          )
              .animate(controller: ingredientController, autoPlay: false)
              .scaleXY(
            begin: 0,
            end: 1,
            duration: 500.ms,
            delay: (200 * index).ms,
            curve: Curves.decelerate,
          )
              .fadeIn();
        },
      ),
    );
  }

}

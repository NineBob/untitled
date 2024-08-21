// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/src/recipes/data/recipe_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';

class AnimatedSelectedCategoryWidget extends StatefulWidget {
  AnimatedSelectedCategoryWidget({Key? key, required this.selectedCategoryPlayDuration, required this.selectedCategoryDelayDuration})
      : super(key: key);
  final selectedCategoryPlayDuration;
  final selectedCategoryDelayDuration;

  State<AnimatedSelectedCategoryWidget> createState() => _AnimatedSelectedCategoryWidget();
}
class _AnimatedSelectedCategoryWidget extends State<AnimatedSelectedCategoryWidget> {
  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: TextField(
         style: TextStyle(color: Colors.black),
        onChanged: (value) {
          // ตอนนี้คุณสามารถใช้ context.read ได้


          setState(() {
            //RecipeRepository(url: 'https://cf44-2001-44c8-4180-513b-a064-8582-8551-fdc1.ngrok-free.app/search/'+value);
          });
        },
        decoration: InputDecoration(
          hintText: 'ค้นหา',
          labelText: 'ค้นหา',
          labelStyle:TextStyle(fontSize: 25) ,
          helperStyle: TextStyle(color: Colors.black,fontSize: 20),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),

          ),
        ),
      )
         );
  }
}

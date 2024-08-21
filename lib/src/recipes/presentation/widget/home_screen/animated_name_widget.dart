import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
class AnimatedNameWidget extends StatelessWidget {
  final Duration namePlayDuration;
  final Duration nameDelayDuration;

  const AnimatedNameWidget({
    super.key,
    required this.namePlayDuration,
    required this.nameDelayDuration,

  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black,size: 35, ),)
        .animate()
        .slideX(
            begin: 0.2,
            end: 0,
            duration: namePlayDuration,
            delay: nameDelayDuration,
            curve: Curves.fastOutSlowIn)
        .fadeIn();
  }
}

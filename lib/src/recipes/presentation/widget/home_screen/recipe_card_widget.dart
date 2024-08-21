// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:dio/dio.dart';
import 'package:untitled/database/Recipes.dart';
import 'dart:typed_data';
import 'dart:convert';

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipeCardWidget({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playDuration = 600.ms;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _AnimatedImageWidget(
              imageUrl: recipe.image,
              playDuration: playDuration,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AnimatedNameWidget(
                    playDuration: playDuration, name: recipe.name_menu),
                _AnimatedDescriptionWidget(
                    playDuration: playDuration, description: recipe.detail),
                _AnimatedNutritionText(
                  playDuration: playDuration,
                  likes_count: recipe.likes_count,
                  number_people: recipe.number_people.toString(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AnimatedNutritionText extends StatelessWidget {
  final Duration playDuration;
  final String number_people;
  final int likes_count;
  const _AnimatedNutritionText({
    Key? key,
    required this.playDuration,
    required this.number_people,
    required this.likes_count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Text(
        "ถูกใจ  $likes_count\t\t\tเหมาสำหรับ  $number_people ",
        style: TextStyle(fontSize: 13, color: Colors.white), //label medium
      ).animate().scaleXY(
          begin: 0,
          end: 1,
          delay: 300.ms,
          duration: playDuration - 100.ms,
          curve: Curves.decelerate),
    );
  }
}

class _AnimatedNameWidget extends StatelessWidget {
  final Duration playDuration;
  final String name;
  const _AnimatedNameWidget({
    Key? key,
    required this.playDuration,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      constraints: const BoxConstraints(maxWidth: 150),
      alignment: Alignment.center,
      child: Text(
        name,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
            color: Colors.white), //title large
      )
          .animate()
          .fadeIn(
              duration: 300.ms, delay: playDuration, curve: Curves.decelerate)
          .slideX(begin: 0.2, end: 0),
    );
  }
}

class _AnimatedDescriptionWidget extends StatelessWidget {
  final Duration playDuration;
  final String description;
  const _AnimatedDescriptionWidget({
    Key? key,
    required this.playDuration,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
      constraints: const BoxConstraints(maxWidth: 150),
      child: Text(description,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              softWrap: true,
              style: Theme.of(context).textTheme.labelLarge //label large
              )
          .animate()
          .scaleXY(
              begin: 0,
              end: 1,
              delay: 300.ms,
              duration: playDuration - 100.ms,
              curve: Curves.decelerate),
    );
  }
}

class _AnimatedImageWidget extends StatelessWidget {
  final Duration playDuration;
  final String imageUrl;
  const _AnimatedImageWidget({
    Key? key,
    required this.playDuration,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 150, maxWidth: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // กำหนดขอบโค้งที่ต้องการ
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // ทำให้ขอบของรูปภาพโค้ง
        child: Image.memory(
          base64Decode(imageUrl.split(',').last),
          width: 150, // ปรับความกว้างของรูปภาพให้ตรงกับ constraints
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    ).animate(delay: 400.ms).shimmer(duration: playDuration - 200.ms).flip();
  }
}

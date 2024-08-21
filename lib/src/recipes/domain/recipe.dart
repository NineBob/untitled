import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
class Recipe with _$Recipe {
  factory Recipe(
      {required String name_menu,
        required String meal,
        required String image,
        required int number_people,
        required List<Map<String,dynamic>> ingredients,
        required List<String> procedure,
        required int likes_count,
        required List<Map<String,dynamic>> seasoning,
        required String userName,
        required String video,
        required int userId,
        required String id,
        required String types,
        required String detail,
        required List<String> liked_by,
      }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/database/model.dart';
class RecipeRepository {
   String url='https://4e37-2001-44c8-4484-44f3-bc9b-e0fa-8670-9535.ngrok-free.app';

  RecipeRepository({this.url = "https://4e37-2001-44c8-4484-44f3-bc9b-e0fa-8670-9535.ngrok-free.app"});
  Future<List<Recipe>> loadRecipes() async {

    try {

      final response = await Dio().get(url);
      final List<dynamic> data = response.data;

      final List<Recipe> recipes = data.map((e) {
        return Recipe(
          name_menu: e['name_menu'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          meal: e['meal'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          image: e['image'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          number_people: e['number_people'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          ingredients: List<Map<String,dynamic>>.from(e['ingredients'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          procedure: List<String>.from(e['procedure'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          id: e['id'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          likes_count: e['likes_count'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          seasoning: List<Map<String,dynamic>>.from(e['seasoning'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          userName: e['userName'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          video: e['video'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          userId: e['userId'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          types: e['types'] ?? '',
          detail: e['detail'] ?? '',
          liked_by: List<String>.from(e['liked_by'] ?? []),
        );
      }).toList();

      return recipes;
    } catch (e) {
      // Handle errors here
      print("Error loading recipes: $e");
      return []; // Return an empty list or throw an exception as needed
    }
  }
  Future<List<Recipe>> searchRecipes(String keyword) async {
    final String searchUrl = "$url/search/$keyword";
    try {
      final response = await Dio().get(searchUrl);
      final List<dynamic> data = response.data;

      final List<Recipe> recipes = data.map((e) {
        return Recipe(
          name_menu: e['name_menu'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          meal: e['meal'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          image: e['image'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          number_people: e['number_people'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          ingredients: List<Map<String,dynamic>>.from(e['ingredients'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          procedure: List<String>.from(e['procedure'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          id: e['id'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          likes_count: e['likes_count'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          seasoning: List<Map<String,dynamic>>.from(e['seasoning'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          userName: e['userName'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          video: e['video'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          userId: e['userId'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          types: e['types'] ?? '',
          detail: e['detail'] ?? '',
          liked_by: List<String>.from(e['liked_by'] ?? []),
        );
      }).toList();

      return recipes;
    } catch (e) {
      // Handle errors here
      print("Error searching recipes: $e");
      return []; // Return an empty list or throw an exception as needed
    }
  }
  Future<List<Recipe>> searchRecipesfool(List<Product> keyword) async {
    String searchUrl = url+'/recipes_flexible/?';
    for(int i=0;i<keyword.length;i++){if(i==0){searchUrl=searchUrl+'ingredients='+keyword[i].name;}else{searchUrl=searchUrl+'&ingredients='+keyword[i].name;}}
   print(searchUrl);
    try {
      final response = await Dio().get(searchUrl);
      final List<dynamic> data = response.data;

      final List<Recipe> recipes = data.map((e) {
        return Recipe(
          name_menu: e['name_menu'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          meal: e['meal'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          image: e['image'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          number_people: e['number_people'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          ingredients: List<Map<String,dynamic>>.from(e['ingredients'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          procedure: List<String>.from(e['procedure'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          id: e['id'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          likes_count: e['likes_count'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          seasoning: List<Map<String,dynamic>>.from(e['seasoning'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
          userName: e['userName'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          video: e['video'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
          userId: e['userId'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
          types: e['types'] ?? '',
          detail: e['detail'] ?? '',
          liked_by: List<String>.from(e['liked_by'] ?? []),
        );
      }).toList();

      return recipes;
    } catch (e) {
      // Handle errors here
      print("Error searching recipes: $e");
      return []; // Return an empty list or throw an exception as needed
    }
  }
   Future<List<Recipe>> searchRecipesfoolsearch(List<Product> keyword,String k) async {
     String searchUrl = url+'/recipes_flexible_search/$k?';
     for(int i=0;i<keyword.length;i++){if(i==0){searchUrl=searchUrl+'ingredients='+keyword[i].name;}else{searchUrl=searchUrl+'&ingredients='+keyword[i].name;}}
     print(searchUrl);
     try {
       final response = await Dio().get(searchUrl);
       final List<dynamic> data = response.data;

       final List<Recipe> recipes = data.map((e) {
         return Recipe(
           name_menu: e['name_menu'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           meal: e['meal'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           image: e['image'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           number_people: e['number_people'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           ingredients: List<Map<String,dynamic>>.from(e['ingredients'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
           procedure: List<String>.from(e['procedure'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
           id: e['id'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           likes_count: e['likes_count'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
           seasoning: List<Map<String,dynamic>>.from(e['seasoning'] ?? []), // ตรวจสอบค่า null และกำหนดเป็น List ว่างหากเป็น null
           userName: e['userName'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           video: e['video'] ?? '', // ตรวจสอบค่า null และกำหนดเป็นค่าว่างหากเป็น null
           userId: e['userId'] ?? 0, // ตรวจสอบค่า null และกำหนดเป็น 0 หากเป็น null
           types: e['types'] ?? '',
           detail: e['detail'] ?? '',
           liked_by: List<String>.from(e['liked_by'] ?? []),
         );
       }).toList();

       return recipes;
     } catch (e) {
       // Handle errors here
       print("Error searching recipes: $e");
       return []; // Return an empty list or throw an exception as needed
     }
   }


}

final repositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepository();
});

final recipesProvider = FutureProvider<List<Recipe>>((ref) async {
  return ref.watch(repositoryProvider).loadRecipes();
});


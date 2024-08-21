// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
  name_menu: json['name_menu'] as String,
  meal: json['meal'] as String,
  image: json['image'] as String,
  number_people: json['number_people'] as int,
  ingredients: (json['ingredients'] as List<dynamic>).map((e) => e as Map<String,dynamic>).toList(),
  procedure: (json['procedure'] as List<dynamic>).map((e) => e as String).toList(),
  id: json['id'] as String,
  likes_count: json['likes_count'] as int,
  seasoning: (json['seasoning'] as List<dynamic>).map((e) => e as Map<String,dynamic>).toList(),
  userName: json['userName'] as String,
  video: json['video'] as String,
  userId: json['userId'] as int,
  types: json['video'] as String,
  detail: json['video'] as String,
  liked_by: (json['liked_by'] as List<dynamic>).map((e) => e as String).toList(),

);

Map<String, dynamic> _$$_RecipeToJson(_$_Recipe instance) => <String, dynamic>{
      'name_menu': instance.name_menu,
      'meal': instance.meal,
      'image': instance.image,
      'number_people': instance.number_people,
      'ingredients': instance.ingredients,
      'procedure': instance.procedure,
      'id': instance.id,
  'likes_count': instance.likes_count,
  'seasoning': instance.seasoning,
  'userName': instance.userName,
  'video': instance.video,
  'userId': instance.userId,
  'types': instance.types,
  'detail': instance.detail,
  'liked_by': instance.liked_by,
};
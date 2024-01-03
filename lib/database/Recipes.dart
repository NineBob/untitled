/*class Recipes {
  final String id;
  final String name;
  final String ingredients;
  final String procedure;
  final String number_people;
  final String Meal;


  Recipes({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.procedure,
    required this.number_people,
    required this.Meal,

  });

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
      id: json['_id'],
      name: json['name_menu'],
      ingredients: json['ingredients'],
      procedure: json['procedure'],
      number_people: json['number_people'],
      Meal: json['Meal'],


    );
  }
}*/
class TodoItem {
  final int userId;
  final int id;
  final String title;
  static const tableName = 'TodoItems';
  static const colName = 'userId';
  static const colDescription = 'id';
  static const colTime = 'title';

  TodoItem({
    required this.userId,
    required this.id,
    required this.title,

  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],

    );
  }
}



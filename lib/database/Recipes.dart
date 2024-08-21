class Recipes {
  final String id;
  final String name_manu;
  final List<dynamic> ingredients;
  final List<dynamic> procedure;
  final String number_people;
  final String meal;
  final String image;
  final int likes_count;
  final List<dynamic> seasoning;
  final int userId;
  final String userName;
  final String video;


  Recipes({
    required this.id,
    required this.name_manu,
    required this.ingredients,
    required this.procedure,
    required this.number_people,
    required this.meal,
    required this.image,
    required this.likes_count,
    required this.seasoning,
    required this.userId,
    required this.userName,
    required this.video,

  });

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
      id: json['_id'],
      name_manu: json['name_manu'],
      ingredients: json['ingredients'],
      procedure: json['procedure'],
      number_people: json['number_people'],
      meal: json['meal'],
      image: json['image'],
      likes_count: json['likes_count'],
      seasoning: json['seasoning'],
      userId: json['userId'],
      userName: json['userName'],
      video: json['video'],


    );
  }
}

class TodoItem {
  final int userId;
  final int id;
  final String title;
  static const tableName = 'TodoItems';
  static const coluserid = 'userId';
  static const colid = 'id';
  static const coltitle = 'title';
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
  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{
      coluserid: userId,
      colid: id,
      coltitle: title,

    };
    return mapData;
  }
}
class universities {
  final String name;
  final String province;
  final String country;
  final String url;


  universities({
    required this.name,
    required this.province,
    required this.country,
    required this.url,

  });

  factory universities.fromJson(Map<String, dynamic> json) {
    return universities(
      name: json['name'],
      province: json['state-province'].toString(),
      country: json['alpha_two_code'],
      url: json['web_pages'].toString(),

    );
  }
}


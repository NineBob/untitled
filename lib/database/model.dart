class Product {
  late String name;
  late double price;
  late String description;
  late String time;
  late String unit;
  late String keep;
  late int favorite;
  late String history;

  static const tableName = 'products';
  static const colName = 'name';
  static const colDescription = 'description';
  static const colTime = 'time';
  static const colPrice = 'price';
  static const colunit = 'unit';
  static const colkeep = 'keep';
  static const colFavorite = 'favorite';
  static const colhistory = 'history';

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.time,
    required this.unit,
    required this.keep,
    required this.favorite,
    required this.history,
  });

  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{
      colName: name,
      colDescription: description,
      colPrice: price,
      colFavorite: favorite,
      colTime:time,
      colunit:unit,
      colkeep:keep,
      colhistory:history,
    };
    return mapData;
  }
}

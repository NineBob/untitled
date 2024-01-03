import 'package:flutter/material.dart';
import 'package:untitled/pages/product.dart';
import 'package:untitled/database/model.dart';
import 'package:untitled/database/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // define main array of products for keeping a product data
  List<Product> products = [];
  late DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;

    initProducts();
  }


  // initial product for showing on screen
  void initProducts() async {
    // init products from SQLite table
    var result = await _dbHelper.fetchProducts();
    setState(() {
      products = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      home: ProductScreen(
        products: products,
        dbHelper: _dbHelper,
      ),
    );
  }
}

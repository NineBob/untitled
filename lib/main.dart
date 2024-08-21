import 'package:untitled/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/product.dart';
import 'package:untitled/database/model.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/pages/signin_screen.dart';
import 'package:untitled/src/core/animation/page_transition.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:untitled/src/recipes/presentation/screens/home_screen.dart';
import 'package:untitled/src/recipes/presentation/screens/recipe_details_screen.dart';
import 'package:untitled/src/core/theme/app_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/database/Recipes.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      theme: mainTheme,
      darkTheme: mainTheme,
      themeMode: ThemeMode.dark,
      locale: DevicePreview.locale(context),
      home: SignInScreen(
        products: products,
        dbHelper: _dbHelper,
      ),
      onGenerateRoute: (settings) {
        return switch (settings.name) {
          'home' => NoAnimationTransition(
            builder: (context) => const HomeScreen(),
          ),
          'recipe_details' => NoAnimationTransition(
            builder: (context) =>
                RecipeDetailsScreen(recipe: settings.arguments as Recipe,dbHelper:_dbHelper ,products: products),
          ),
          _ => NoAnimationTransition(builder: (context) => const HomeScreen())
        };
      },

    );
    /*return MaterialApp(
      title: 'Auth Screen 1',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineMedium:
          TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.2),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:SignInScreen(products: products,
        dbHelper: _dbHelper,),
    );*/
  }
}

class WelcomeScreen extends StatelessWidget {
  List<Product> products = [];
  late DatabaseHelper _dbHelper;

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/peros.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "MANAGE MATERIAL",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),

                    ],
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ProductScreen(products: products,
                            dbHelper: _dbHelper,);
                        },
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 25),
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kPrimaryColor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "START ",

                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';
import 'package:untitled/src/core/widget/annotated_scaffold.dart';
import 'package:untitled/src/recipes/presentation/widget/recipe_details/recipe_details_widgets.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/model.dart';
import 'package:untitled/src/recipes/presentation/widget/recipe_details/r.dart';
import 'package:untitled/pages/Dashboard.dart';

class RecipeDetailsScreen extends StatefulWidget {
  RecipeDetailsScreen({
    Key? key,
    required this.products,
    required this.dbHelper,
    required this.recipe,
  }) : super(key: key);
  final Recipe recipe;
  List<Product> products;
  DatabaseHelper dbHelper;
  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int quantity = 0;
  int c = 0;
  double countre = 0;
  @override
  Widget build(BuildContext context) {
    int ree = widget.recipe.ingredients.length;
    int s = widget.recipe.number_people;
    if (quantity != s && c == 0) {
      quantity = s;
      c++;
    }
    double countr = quantity / s;

    countre = double.parse(countr.toStringAsFixed(1));

    return AnnotatedScaffold(
      child: LayoutBuilder(builder: (context, constraints) {
        final appBarPlayTime = 800.ms;
        final appBarDelayTime = 400.ms;
        final infoDelayTime = appBarPlayTime + appBarDelayTime - 200.ms;
        final infoPlayTime = 500.ms;
        final dishPlayTime = 600.ms;
        return TimeLineSlidingPanel(
            recipe: widget.recipe,
            count: countr,
            constraints: constraints,
            body: Column(
              children: [
                AnimatedAppBarWidget(
                  name: widget.recipe.name_menu,
                  appBarPlayTime: appBarPlayTime,
                  appBarDelayTime: appBarDelayTime,
                  dbHelper: widget.dbHelper,
                  products: widget.products,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.04,
                ),
                AnimatedDishWidget(

                  name: widget.recipe.name_menu,
                  constraints: constraints,
                  imageUrl: widget.recipe.image,
                  dishPlayTime: dishPlayTime,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.06,
                ),
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (quantity > 1) {
                              quantity--;
                            }
                          });
                        },
                        icon: const Icon(Icons.remove, color: Colors.black),
                      ),
                      Text(
                        quantity.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 23),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '(คน)',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(
                                dbHelper: widget.dbHelper,
                                products: widget.products,
                                recipe: widget.recipe,
                                contun: countr,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              'ตัดสต๊อก',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                      )
                    ],
                  ),
                ),
              ],
            ));
      }),
    );
  }
}

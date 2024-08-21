import 'package:untitled/src/core/widget/annotated_scaffold.dart';
import 'package:untitled/src/recipes/presentation/widget/home_screen/animated_appbar_widget.dart'
as home;
import 'package:untitled/src/recipes/presentation/widget/home_screen/home_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/src/recipes/data/recipe_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/src/recipes/presentation/widget/home_screen/loaded_recipes_widget.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/model.dart';
class HomeScreenfool extends StatefulWidget {
  HomeScreenfool({
    Key? key,required this.products,

  }) : super(key: key);

  List<Product> products;


  @override
  State<HomeScreenfool> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenfool> {
  bool _showRecipeList = false;
  bool _showRecipeList1 = true;
  String sw='';
  void changeListVisibility() {
    setState(() {
      _showRecipeList = true;
    });
  }

  @override
  void initState() {
    Future.delayed(2550.ms, () => changeListVisibility());
    super.initState();
  }

  @override
  Widget build(
      BuildContext context,
      ) {

    final avatarPlayDuration = 500.ms;
    final avatarWaitingDuration = 400.ms;
    final nameDelayDuration =
        avatarWaitingDuration + avatarWaitingDuration + 200.ms;
    final namePlayDuration = 800.ms;
    final categoryListPlayDuration = 750.ms;
    final categoryListDelayDuration =
        nameDelayDuration + namePlayDuration - 400.ms;
    final selectedCategoryPlayDuration = 400.ms;
    final selectedCategoryDelayDuration =
        categoryListDelayDuration + categoryListPlayDuration;
    return AnnotatedScaffold(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                home.AnimatedAppBarWidget(
                    avatarWaitingDuration: avatarWaitingDuration,
                    avatarPlayDuration: avatarPlayDuration,
                    nameDelayDuration: nameDelayDuration,
                    namePlayDuration: namePlayDuration),
                const SizedBox(
                  height: 30,
                ),
                /*AnimatedCategoryList(
                  categoryListPlayDuration: categoryListPlayDuration,
                  categoryListDelayDuration: categoryListDelayDuration,
                ),*/
                const SizedBox(
                  height: 0,
                ),
                Padding(padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      if (value != null && value.isNotEmpty) {
                        sw=value;
                        setState(() {
                          _showRecipeList1 = true;
                        });

                      } else {
                        sw='';
                        setState(() {
                          _showRecipeList1 = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'ค้นหา',
                      labelStyle:TextStyle(fontSize: 25,color: Colors.black54) ,
                      prefixIcon: Icon(Icons.search,color: Colors.black,size: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),

                      ),
                    ),
                  ).animate()
                      .fadeIn(
                      delay: selectedCategoryDelayDuration,
                      duration: selectedCategoryPlayDuration,
                      curve: Curves.decelerate)
                      .slideX(begin: 0.2, end: 0),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          _showRecipeList
              ? AnimatedRecipesWidget(value:sw,products:widget.products,)
              : const SliverToBoxAdapter(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

}

class AnimatedRecipesWidget extends ConsumerWidget {
  final String value;
  final List<Product> products;
  const AnimatedRecipesWidget({
    required this.value,
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final recipes = ref.watch(recipesProvider);
    if (value.isEmpty) {
      return FutureBuilder<List<Recipe>>(
        future: ref.watch(repositoryProvider).searchRecipesfool(products),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return LoadedRecipesWidget(
              recipes: snapshot.data!,
            );
          }
        },
      );
    } else {
      return FutureBuilder<List<Recipe>>(
        future: ref.watch(repositoryProvider).searchRecipesfoolsearch(products,value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else {
            return LoadedRecipesWidget(
              recipes: snapshot.data!,
            );
          }
        },
      );
    }
  }
}



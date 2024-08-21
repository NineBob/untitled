// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/pages/signin_screen.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/model.dart';
class AnimatedAppBarWidget extends StatelessWidget {
  final String name;
  final Duration appBarPlayTime;
  final Duration appBarDelayTime;
  final List<Product> products;
  final DatabaseHelper dbHelper;
  const AnimatedAppBarWidget({
    Key? key,
    required this.name,
    required this.appBarPlayTime,
    required this.appBarDelayTime,
    required this.products,
    required this.dbHelper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 25,
              color: Colors.black,
            )),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black,fontSize: 25),
        ),
        IconButton(
            onPressed: () {Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>SignInScreen(products: products,dbHelper: dbHelper,)
              ),
            );},
            icon: const Icon(
              Icons.home,
              size: 30,
              color: Colors.black,
            ))
      ].animate(interval: 200.ms, delay: appBarDelayTime).scaleXY(
          begin: 0, end: 1, duration: appBarPlayTime, curve: Curves.decelerate),
    );
  }
}

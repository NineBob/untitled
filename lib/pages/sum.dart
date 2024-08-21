import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:untitled/pages/product.dart';
import '../database/model.dart';
import 'package:untitled/database/database_helper.dart';
class Listt extends StatelessWidget {
  final String namep;
  final String dt;
  final List<Product> products;
  final DatabaseHelper dbHelper;
  const Listt({
    Key? key,
    required this.namep,
    required this.dt,
    required this.products,
    required this.dbHelper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                products: products,
                dbHelper: dbHelper,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.redAccent.shade200,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ไอคอนที่ต้องการ
              SizedBox(width: 4.0),
              Text(
                namep,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(width: 8.0),
            ],
          ),
        ),
      ),
    );




  }
}

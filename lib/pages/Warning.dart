import 'package:flutter/material.dart';
import 'package:untitled/pages/Warning.dart';
import 'package:dio/dio.dart';
import '../database/model.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/Recipes.dart';
import 'package:untitled/main.dart';
import 'dart:convert';

class Warning extends StatefulWidget {
  Warning({Key? key, required this.products, required this.dbHelper})
      : super(key: key);

  List<Product> products;
  DatabaseHelper dbHelper;

  @override
  State<Warning> createState() => _HomePageState();
}

class _HomePageState extends State<Warning> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));
  //List<Recipes>? _itemList;
  List<TodoItem>? _itemList;
  List<TodoItem>? y;
  String? _error;

  void getTodos() async {
    try {
      setState(() {
        _error = null;
      });

      // await Future.delayed(const Duration(seconds: 3), () {});

      //final response = await _dio.get('https://5c99-202-28-73-167.ngrok-free.app/api/recipes');
      final response = await _dio.get('https://jsonplaceholder.typicode.com/albums');
      debugPrint(response.data.toString());
      // parse
      List list = jsonDecode(response.data.toString());
      setState(() {
        //_itemList = list.map((item) => Recipes.fromJson(item)).toList();
        _itemList = list.map((item) => TodoItem.fromJson(item)).toList();
        for(int i =0;i<_itemList!.length;i++){var s =_itemList![i];y!.add(s);}
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
      debugPrint('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_error != null) {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_error!),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              getTodos();
            },
            child: const Text('RETRY'),
          )
        ],
      );
    } else if (y == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = ListView.builder(
          itemCount: y!.length,
          itemBuilder: (context, index) {
            var todoItem = y![index];
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              //Text(todoItem.name)
                              Text(todoItem.userId.toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                //child: Text("procedure: " + todoItem.procedure),
                                child: Text("procedure: " + todoItem.id.toString()),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                //child: Text("procedure: " + todoItem.ingredients),
                                child: Text("procedure: " + todoItem.title),
                              ),

                            ],
                          ),
                        )

                      ],
                    )

                )

            );
          });
    }

    return Scaffold(appBar: AppBar(title: Center(child: const Text('Recipes',))), body: body );
  }
}
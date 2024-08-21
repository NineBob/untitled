import 'package:flutter/material.dart';
import 'package:untitled/pages/Warning.dart';
import 'package:dio/dio.dart';
import '../database/model.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/Recipes.dart';
import 'package:untitled/main.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
   HomePage({Key? key, required this.products, required this.dbHelper})
      : super(key: key);

  List<Product> products;
  DatabaseHelper dbHelper;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));
  List<Recipes>? _itemList;
 int ii =6;
  String? _error;

  void getTodos() async {
    try {
      setState(() {
        _error = null;
      });
      //await Future.delayed(const Duration(seconds: 3), () {});
      final response = await _dio.get('https://13ac-2001-44c8-404a-3b27-34d5-1556-4cca-ed2f.ngrok-free.app');
      debugPrint(response.data.toString());
      // parse
      List list = jsonDecode(response.data.toString());
      setState(() {
        _itemList = list.map((item) => Recipes.fromJson(item)).toList();

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
    } else if (_itemList == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      ii=ii+1;
      body = ListView.builder(
          itemCount: _itemList!.length,
          itemBuilder: (context, index) {
            var todoItem = _itemList![index];
            return Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(todoItem.name_manu,style:TextStyle(fontSize: 20)),
                            
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.brown.shade50,
                            borderRadius: BorderRadius.circular(30),

                          ),
                          padding: const EdgeInsets.all(8.0),
                          //child:Image.asset('assets/'+todoItem.Meal+'.jpg',) ,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child:Image.asset('assets/'+todoItem.meal+'.jpg',) ,

                          ),
                        ),
                        Padding(

                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("วัตถุดิบ: " + todoItem.ingredients.toString(),),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text("เหมาะสำหรับ: " + todoItem.number_people),
                              ),
                              ElevatedButton(
                                style:  ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),backgroundColor: Colors.brown.shade600),
                                onPressed:()async{
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(productdetail: todoItem),
                                    ),
                                  );
                                }
                                ,
                                child: Text('เพิ่มเติม'),
                              ),

                            ],
                          ),

                        )

                      ],

                    )

                ),

            );
          });
    }

    return Scaffold(appBar: AppBar(title: Padding(child: const Text('สูตรอาหาร',),padding: EdgeInsets.all(85)),backgroundColor: Colors.yellow.shade800), body: body );
  }
}
class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.productdetail}) : super(key: key);
  final Recipes productdetail;

  @override
  Widget build(BuildContext context) {

    //var d= int.parse(productdetail.time.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 60,

        backgroundColor: Colors.yellow.shade800,
        title: Text(productdetail.name_manu,style: TextStyle(fontSize: 25,color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            height: 250,width:250 ,
            padding: EdgeInsets.all( 35),
            child:Image.asset('assets/'+productdetail.meal+'.jpg') ,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 0.0),
            child: Text('เมนู: '+productdetail.procedure.toString(),style: TextStyle(fontSize: 17,color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 10.0),
            child: Text('วัตถุดิบ: ${productdetail. ingredients}',style: TextStyle(fontSize: 17,color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 10.0),
            child: Text('ขั้นตอนการทำ:',style: TextStyle(fontSize: 17 ,color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 10.0),
            child: Text(' ${productdetail.procedure}',style: TextStyle(fontSize: 17 ,color: Colors.black)),
          ),
          const SizedBox(height: 30),



        ],),
      ),

    );
  }
}
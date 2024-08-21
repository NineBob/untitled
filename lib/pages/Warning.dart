/*import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/Warning.dart';
import 'package:dio/dio.dart';
import '../database/model.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/Recipes.dart';
import 'package:untitled/main.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  List<Recipes>? _itemList;
  List<Recipes>? y=[];
  String? _error;
  List<Product>? products1;
  String sum="";
  String ex="";
  List<String> e=[];
  double kile=0;

  void getTodos() async {
    try {
      setState(() {
        _error = null;
      });

      // await Future.delayed(const Duration(seconds: 3), () {});
      final response = await _dio.get('https://4b46-2001-44c8-4180-513b-ce-defe-f9f-693b.ngrok-free.app');
      debugPrint(response.data.toString());
      // parse
      List list = jsonDecode(response.data.toString());
      setState(() {
        products1=widget.products;
        _itemList = list.map((item) => Recipes.fromJson(item)).toList();
        for(int i =0;i<_itemList!.length;i++){
          for(int u=0;u<products1!.length;u++){
            if(products1![u].name==_itemList![i].name_manu){
              y!.add(_itemList![i]);
            }
          }
          }
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
   void _showConfirmDalog(){
       showDialog(
          context: context,
          builder:(context){
            return AlertDialog(
              title:Text ('คุณต้องการตัดสต๊อกหรือมั้ย?'),
              actions: [ElevatedButton(onPressed: ()async{
              e=[];
              sum.characters.indexed.length;
              for(int i=0;i<sum.characters.indexed.length;i++){
                String ss=' ';
                if(sum.characters.characterAt(i)==ss.characters){
                  e.add(ex);
                  ex='';
                }
                else{ex=ex+sum.characters.characterAt(i).toString();}
              }
              /*
                                    for(int i=0;i<_itemList![index].ingredients.length;i++){
                                    var start =sum.indexOf(' ');
                                    ex=sum.substring(0,start);
                                    e.add(ex);
                                    }*/
              for(int o=0;o<e.length;o++){
                for(int i=0;i<widget.products.length;i++) {
                  if (e[o] == widget.products[i].name) {
                    if(e[i+2]=='กก'){
                      kile= double.parse(e[o+1]);
                    }
                    else{kile= double.parse(e[o+1]);kile=kile/1000;}
                    widget.dbHelper.updateProduct(Product(
                        name: widget.products[i].name,
                        description: widget.products[i]
                            .description,
                        price: widget.products[i].price-kile,
                        time: widget.products[i].time,
                        favorite: widget.products[i].favorite,
                      keep: widget.products[i].keep,
                      unit: widget.products[i].unit
                    ));
                    var result = await Product(
                        name: widget.products[i].name,
                        description: widget.products[i]
                            .description,
                        price: widget.products[i].price-kile,
                        time: widget.products[i].time,
                        favorite: widget.products[i].favorite,
                        keep: widget.products[i].keep,
                        unit: widget.products[i].unit
                    );
                    setState(() {
                      widget.products[i] = result;

                    });
                  }
                }
              }
              Navigator.pop(context);
            } ,
                  child: const Text('ใช่')),
                ElevatedButton(onPressed:(){Navigator.pop(context);},
                    child: const Text('ไม่'))
              ],
            );
          }
      );
    }
    if (_error != null) {
      print('yuuuuu'+_itemList.toString());
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
                          padding: const EdgeInsets.all(4.0),
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
                            child:Image.asset(todoItem.image) ,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                //child: Text("procedure: " + todoItem.procedure),
                                child: Text("วัตถุดิบ: " + todoItem.name_manu),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Expanded(
                                //child: Text("procedure: " + todoItem.ingredients),
                                child: Text( "เหมาะสำหรับ: " + todoItem.number_people),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 30,
                                decoration:BoxDecoration(
                                    color: Colors.brown.shade600,
                                    borderRadius: BorderRadius.circular(5)
                                ) ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      CupertinoIcons.minus,
                                      color: Colors.white,
                                    ),
                                    Text('1',style: TextStyle(color: Colors.white),),
                                    Icon(
                                      CupertinoIcons.plus,
                                      color: Colors.white,
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(width: 150),
                              ElevatedButton(
                                style:  ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),backgroundColor: Colors.brown.shade600),
                                onPressed:()async{
                                  sum=_itemList![index].ingredients.first;
                                  _showConfirmDalog();
                                }
                                ,
                                child: Text('ตัดสต๊อก'),
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

                        ),

                      ],
                    )

                )

            );
          });
    }

    return Scaffold(appBar: AppBar(title: Padding(child: const Text('สูตรอาหารที่ทำได้',),padding: EdgeInsets.all(65)),backgroundColor: Colors.yellow.shade800), body: body );
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
              child: Text('เมนู: '+productdetail.name_manu,style: TextStyle(fontSize: 17,color: Colors.black)),
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
*/

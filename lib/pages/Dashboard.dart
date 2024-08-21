import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/src/recipes/domain/recipe.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key? key,
    required this.products,
    required this.dbHelper,
    required this.recipe,
    required this.contun,
  }) : super(key: key);
  final Recipe recipe;
  List<Product> products;
  DatabaseHelper dbHelper;
  double contun;
  @override
  _dashboard createState() => _dashboard();
}
class _dashboard extends State<Dashboard> {

  List<String> po=[];
  int con=0;
  int conn=-1;
  List<String> pos=[];
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.recipe.ingredients.length; i++) {
      for (int o = 0; o < widget.products.length; o++) {
        var ingredient = widget.recipe.ingredients[i];
        if (widget.products[o].name == ingredient['name']) {
          double ss=widget.products[o].price;
          if(ingredient['unit']=='หัว'&&widget.products[o].price%1!=0){
          po.add(ss.toStringAsFixed(1));}
          else{if (ingredient['unit'] != widget.products[o].unit) {
            if (widget.products[o].unit == 'กิโลกรัม') {
              ss = ss * 1000;
            }
          }po.add(ss.toStringAsFixed(0));}
          con++;

        }
      }
      if (con != i+1) {
        po.add('-');
        con++;
      }

    }
    for (int i = 0; i < widget.recipe.ingredients.length; i++) {
      var ingredient = widget.recipe.ingredients[i];
      for (int o = 0; o < widget.products.length; o++) {
        double num1 = double.parse(ingredient['amount']) * widget.contun;
        if (widget.products[o].name == ingredient['name']&&widget.products[o].price>=num1) {
          double coon = widget.products[o].price ;
          if (ingredient['unit'] != widget.products[o].unit) {
            if (widget.products[o].unit == 'กิโลกรัม') {
              coon = coon * 1000;
            }
          }
          coon=coon - num1;
          if(ingredient['unit']=='หัว'&&coon%1!=0){pos.add(coon.toStringAsFixed(1));}
          else{
          pos.add(coon.toStringAsFixed(0));}
          conn++;
        }
        if (widget.products[o].name == ingredient['name']&&widget.products[o].price<num1) {
          double coon = widget.products[o].price ;
          if (ingredient['unit'] != widget.products[o].unit) {
            if (widget.products[o].unit == 'กิโลกรัม') {
              coon = coon * 1000;
            }
          }
          coon=(coon - num1)*-1;
          if(ingredient['unit']=='หัว'&&coon%1!=0){pos.add('ขาด ' +coon.toStringAsFixed(1));}
          else{
            pos.add('ขาด ' + coon.toStringAsFixed(0));}
          conn++;
        }
      }
      if (conn != i) {
        double num2 = double.parse(ingredient['amount']) * widget.contun;
        if(ingredient['unit']=='หัว'&&num2%1!=0){ pos.add('ขาด ' + num2.toStringAsFixed(1));}
        else{
        pos.add('ขาด ' + num2.toStringAsFixed(0));}
        conn++;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สรุปรายการตัดสต๊อก',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle the home button press here.
            },
          ),
        ],
      ),

      body: Container(
        padding: EdgeInsets.only(bottom: 16,top: 24,left: 16,right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อวัตถุดิบ            ที่ต้องใช้           ที่มีอยู่        คงเหลือ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15), // Adds some space between the text and the list
            Expanded(
              child: ListView.builder(
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  final item = widget.recipe.ingredients[index];
                  final itemp = po[index];
                  final itempp = pos[index];
                  print(pos);
                  String k = item['amount'];
                  double doubleValue = double.parse(k);
                  doubleValue = doubleValue * widget.contun;
                  String bv='';
                  if(item['unit']=='หัว'&&doubleValue%1!=0){bv=doubleValue.toStringAsFixed(1);}
                  else{bv=doubleValue.toStringAsFixed(0);}
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${item['name']}',
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              bv+' ${item['unit']}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFeatures: [FontFeature.tabularFigures()]),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${itemp} '+'${item['unit']}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFeatures: [FontFeature.tabularFigures()]),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${itempp} '+'${item['unit']}',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.black,fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    for (int i = 0; i < widget.recipe.ingredients.length; i++) {
                      var ingredient = widget.recipe.ingredients[i];
                      for (int o = 0; widget.products.length > o; o++) {
                        if (ingredient['name'] == widget.products[o].name) {
                          double intin = double.parse(ingredient['amount']) *
                              widget.contun;
                          if (ingredient['unit'] == 'ฟอง') {
                            intin = intin.round().toDouble();
                          }
                          if (ingredient['unit'] != widget.products[o].unit) {
                            if (ingredient['unit'] == 'กรัม') {
                              intin = intin / 1000;
                            }
                            if (ingredient['unit'] == 'กิโลกรัม') {
                              intin = intin * 1000;
                            }
                          }
                          if ((intin) < widget.products[o].price) {
                            widget.dbHelper.updateProduct(Product(
                              name: widget.products[o].name,
                              description: widget.products[o].description,
                              price: widget.products[o].price - intin,
                              time: widget.products[o].time,
                              favorite: widget.products[o].favorite,
                              keep: widget.products[o].keep,
                              unit: widget.products[o].unit,
                              history: widget.products[o].history,
                            ));
                            var result = await Product(
                              name: widget.products[o].name,
                              description: widget.products[o].description,
                              price: widget.products[o].price - intin,
                              time: widget.products[o].time,
                              favorite: widget.products[o].favorite,
                              keep: widget.products[o].keep,
                              unit: widget.products[o].unit,
                              history: widget.products[o].history,
                            );
                            setState(() {
                              widget.products[o] = result;
                            });
                          } else {
                            widget.dbHelper.deleteProduct(widget.products[o].name);
                            setState(() {
                              widget.products.removeAt(o);
                            });
                          }
                        }
                      }
                    }
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'ตัดสต๊อกไม่สำเร็จ',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              SnackBarAction(
                                label: 'ดูรายการวัตถุดิบที่ใช้',
                                onPressed: () {
                                  // Handle the "See More" action here.
                                },
                                textColor: Colors.blue.shade800, // Optional: set the text color of the action button
                              ),
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(horizontal: 20), // Adjust the margin as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );


                  },
                  child: Text(
                    'ตัดสต๊อก',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
                SizedBox(width: 24), // เพิ่มช่องว่างระหว่างปุ่ม
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ยกเลิก',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



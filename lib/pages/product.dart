import 'package:flutter/material.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/pages/Warning.dart';
import 'package:untitled/pages/home.dart';
import 'package:sqflite/sqflite.dart';
import '../database/model.dart';
import 'package:untitled/pages/searh.dart';
import 'package:untitled/pages/signin_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key, required this.products, required this.dbHelper})
      : super(key: key);

  List<Product> products;
  DatabaseHelper dbHelper;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    Future<dynamic> _showConfirmDalog(BuildContext context, String action) {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text('คุณต้องการ $action หรือมั้ย?'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('ใช่', style: TextStyle(fontSize: 15))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400),
                    child: const Text(
                      'ไม่',
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            );
          });
    }

    var ttime = DateTime.now().toString();
    var d2 = int.parse(ttime.substring(8, 10));
    var mm = int.parse(ttime.substring(5, 7));
    var yy = int.parse(ttime.substring(0, 4));
    int ddd = d2 + (mm * 30);
    int dddd = (d2 + (mm * 30)) + 3;
    Widget getTrailingIcon(String dateString) {
      // Parsing date components
      int day = int.parse(dateString.substring(8, 10));
      int month = int.parse(dateString.substring(5, 7));
      int totalDays = day + (month * 30);
      int totalDays3 = day + ((month * 30) + 3);

      // Date comparison variables
      int currentDateDays = (int.parse(dateString.substring(8, 10)) +
          (int.parse(dateString.substring(5, 7)) *
              30)); // Calculate the current date in similar total days format if needed
      // Set any threshold date in total days format if needed

      if (dateString == '2024-05-20') {
        return const Icon(Icons.question_mark_rounded, color: Colors.grey);
      } else if (totalDays > currentDateDays) {
        return const Icon(Icons.delete_outline_rounded,
            color: Colors.red, size: 30);
      } else if (totalDays3 > currentDateDays) {
        return const Icon(Icons.access_time, color: Colors.orange);
      } else {
        return const Icon(Icons.access_time, color: Colors.green);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      /*bottomNavigationBar: ConvexAppBar(
        curveSize: 100,
        elevation: 5,
        height: 70,
        items: [
          TabItem(icon: Icons.book_outlined, title: 'สูตรอาหาร'),
          TabItem(icon: Icons.map, title: 'เพิมเติม'),
          TabItem(icon: Icons.backup_table, title: 'วัตถุดิบ'),
          TabItem(icon: Icons.message, title: 'เพิมเติม'),
          TabItem(icon: Icons.star_purple500_sharp, title: 'สูตรเเนะนำ'),
        ],
        gradient: LinearGradient(
            colors: [Colors.yellow.shade600, Colors.yellow.shade800]
        ),
        initialActiveIndex: 2, //optional, default as 0
        onTap: (val) {
          if(val==0){Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(products: widget.products,dbHelper: widget.dbHelper,)),);
          }
          if(val==4){ Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Warning(products: widget.products,dbHelper: widget.dbHelper,)),
          );}
          },
      ),*/
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () async {
            var result = await ModalProductForm(
                products: widget.products, dbHelper: widget.dbHelper)
                .showModalInputForm(context);
            setState(() {
              if (result != null) {
                widget.products = result;
              }
            });
          },
          child: const Icon(Icons.add, size: 45, color: Colors.white),
        ),
      ),
      appBar: AppBar(
        actions: [
          /*IconButton(
            color: Colors.white,
            iconSize: 35.0,
            hoverColor: Colors.white70,
              onPressed: () async {
                var result = await ModalProductForm(
                    products: widget.products, dbHelper: widget.dbHelper)
                    .showModalInputForm(context);
                setState(() {
                  if (result != null) {
                    widget.products = result;
                  }
                });
              },
              icon: const Icon(Icons.add_box_rounded)
          ),*/
          Column(children: [
            Container(
              padding: EdgeInsets.only(top: 15),
              child: IconButton(
                  color: Colors.red,
                  iconSize: 35.0,
                  hoverColor: Colors.white70,
                  onPressed: () {
                    /* Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=>SearchProduct(products: widget.products,dbHelper: widget.dbHelper,)
                    ),
                );*/
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SignInScreen(
                            products: widget.products,
                            dbHelper: widget.dbHelper,
                          )),
                    );
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  )),
              /*decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(blurRadius: 7,spreadRadius: 3,
                        color: Colors.green
                    )
                  ],
                  shape: BoxShape.circle,
                  color: Colors.green.shade400

              ),*/
            )
          ]),

          // Text('Add product',),
          Text(
            '      ',
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(0))),
        title: const Text('รายการวัตถุดิบ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            )),
        toolbarHeight: 80,
        centerTitle: false,
        backgroundColor: Colors.orange,

      ),

      body: ListView.separated(
        separatorBuilder: (context, index) {
          //<-- SEE HERE
          return Divider(
            thickness: 1,
          );
        },
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 25),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          // ** Edit ** Wrap this Card with Dismissible widget for swipable
          return Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.blue),

            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 30),
              child: const Icon(Icons.delete_outlined,
                  color: Colors.white, size: 30),
            ),
            onDismissed: (direction) {
              String prodductdeleted = widget.products[index].name;
              if (direction == DismissDirection.endToStart) {
                widget.dbHelper.deleteProduct(widget.products[index].name);
              }
              setState(() {
                widget.products.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ลบ$prodductdeletedสำเร็จเเล้ว')));
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await _showConfirmDalog(context, 'ลบ');
              }
              return false;
            },
            direction: DismissDirection.horizontal,
          child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
          BoxShadow(
          color: Colors.black54, // สีเงา
          spreadRadius: 1, // ขยายเงา
          blurRadius: 3, // เบลอเงา
          offset: Offset(2, 2), // ตำแหน่งเงา
          ),
          ],
          ),

            child: ListTile(
              visualDensity: VisualDensity(vertical: 0),
              tileColor: Colors.grey.shade300,
              contentPadding: EdgeInsets.all(8),
              shape: ddd >
                  (int.parse(widget.products[index].time.substring(8, 10)) +
                      (int.parse(
                          widget.products[index].time.substring(5, 7)) *
                          30))
                  ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(width: 3, color: Colors.white),

              )
                  : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),

                side: BorderSide(width: 3, color: Colors.white),
              ),
              title: Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0), // กำหนดระยะห่างด้านบนของ title
                child: Text(
                  widget.products[index].name,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              subtitle: widget.products[index].time == '2024-05-20'
                  ? Text(
                'ปริมาณ:${widget.products[index].price.toStringAsFixed(1)} '+
                    '${widget.products[index].unit} '+
                    'วันหมดอายุ:ไม่ทราบ ' +
                    '(${widget.products[index].keep})',
                style: TextStyle(color: Colors.black),
              )
                  : Text(
                'ปริมาณ:${widget.products[index].price.toStringAsFixed(1)} '+
                    '${widget.products[index].unit} '+
                    'วันหมดอายุ:${widget.products[index].time} ' +
                    '(${widget.products[index].keep})',
                style: TextStyle(color: Colors.black),
              ),
              trailing: widget.products[index].time == '2024-05-20'
                  ? const Icon(
                Icons.question_mark_rounded,
                color: Colors.black,
              )
                  : ddd >
                  (int.parse(widget.products[index].time
                      .substring(8, 10)) +
                      (int.parse(widget.products[index].time
                          .substring(5, 7)) *
                          30))
                  ? const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 30,
              )
                  : dddd >
                  (int.parse(widget.products[index].time
                      .substring(8, 10)) +
                      (int.parse(widget.products[index].time
                          .substring(5, 7)) *
                          30))
                  ? const Icon(
                Icons.access_time,
                color: Colors.orange,
              )
                  : const Icon(
                Icons.access_time,
                color: Colors.green,
              ),
              onTap: () async {/*
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                        productdetail: widget.products[index],
                        dbHelper: widget.dbHelper),
                  ),
                );
                setState(() {
                  if (result != null) {
                    widget.products[index].favorite = result;
                    widget.dbHelper.updateProduct(widget.products[index]);
                    // ** Edit : Call update method here (for favorite flag)
                  }
                });*/
              },
              onLongPress: () async {
                var result = await ModalEditproductForm(
                    productDetail: widget.products[index],
                    dbHelper: widget.dbHelper)
                    .showModalInputForm(context);
                setState(() {
                  if (result != null) {
                    widget.products[index] = result;
                  }
                });
              },
            ),
          ));
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen(
      {Key? key, required this.productdetail, required this.dbHelper})
      : super(key: key);
  final DatabaseHelper dbHelper;
  final Product productdetail;

  @override
  Widget build(BuildContext context) {
    var result = productdetail.favorite;
    //var d= int.parse(productdetail.time.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        backgroundColor: Colors.green[400],
        title: Text(productdetail.name,
            style: TextStyle(fontSize: 25, color: Colors.black)),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 5, spreadRadius: 2, color: Colors.green)
            ], shape: BoxShape.circle, color: Colors.green.shade400),
            padding: EdgeInsets.all(35),
            child: Image.asset(
              'assets/3.png',
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('Type: ' + productdetail.description,
                style: TextStyle(fontSize: 17, color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('quantity: ${productdetail.price.toString()}',
                style: TextStyle(fontSize: 17, color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('Date: ${productdetail.time}',
                style: TextStyle(fontSize: 17, color: Colors.black)),
          ),
          Container(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      backgroundColor: Colors.redAccent),
                  child: const Text(
                    'Delete',
                  ),
                  onPressed: () {
                    Navigator.pop(context, result);
                  },
                ),
                ElevatedButton(
                  child: const Text('Edic'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      backgroundColor: Colors.blue.shade800),
                  onPressed: () async {
                    Product it = Product(
                        name: productdetail.name,
                        description: productdetail.description,
                        price: productdetail.price,
                        time: productdetail.time,
                        favorite: productdetail.favorite,
                        unit: productdetail.unit,
                        keep: productdetail.keep,
                        history: productdetail.history);
                    result = await ModalEditproductForm(
                        productDetail: it, dbHelper: dbHelper)
                        .showModalInputForm(context);
                    Navigator.pop(context, result);
                  },
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ModalProductForm {
  ModalProductForm({Key? key, required this.products, required this.dbHelper});
  String? selectedValue = 'ประเภท';

  Future<String?> showProductSuggestions(
      BuildContext context, List<String> suggestions) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายการวัตถุดิบที่เคยเก็บ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: suggestions.length * 2 - 1, // Adjusted item count for dividers
              itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) { // Check if index is odd (divider position)
                  return Divider(
                    color: Colors.orange, // Set divider color to black
                  );
                }
                final int suggestionIndex = index ~/ 2; // Calculate actual suggestion index
                return ListTile(
                  title: Text(suggestions[suggestionIndex],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 18)),
                  onTap: () {
                    Navigator.of(context).pop(suggestions[suggestionIndex]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }



  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String?> _radioValueNotifier =
  ValueNotifier<String?>('ทราบวันหมดอายุ');
  ValueNotifier<String?> selectedValues = ValueNotifier('ประเภท');
  ValueNotifier<String?> selectedValuees = ValueNotifier('หน่วย');
  ValueNotifier<String?> selectedValueees = ValueNotifier('ช่องเก็บ');
  String? selectedValuee = 'หน่วย';
  String? selectedValueee = 'ช่องเก็บ';
  DateTime date = DateTime.now();
  var Items = ['ประเภท', 'เนื้อสัตว์', 'ผัก', 'ไข่','ผลไม้','อื่นๆ'];
  var Itemss = [
    'หน่วย',
    'กรัม',
    'กิโลกรัม',
    'หัว',
    'หลอด',
    'ก้อน',
    'เม็ด',
    'ฟอง',
    'ลูก',
    'ใบ',
    'ต้น',
    'อื่นๆ'
  ];
  var Itemsss = ['ช่องเก็บ', 'ช่องปกติ', 'ช่องฟรีส'];
  String erroe = '';
  String noerroe = 'ถูกต้อง';
  List<Product> products;
  DatabaseHelper dbHelper;
  String _name = '', _description = '', _unti = '', _keep = '', _history = '';
  var connn = [''];
  double _price = 0;
  final int _favorite = 0;
  String _time = '2024-05-20';
  String _radioValue = 'ไม่ทราบวันหมดอายุ';

  Future<dynamic> showModalInputForm(BuildContext context) {
    for (int i = 0; i < products.length; i++) {
      connn.add(products[i].history);
    }
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Center(
                    child: Text(
                      'แบบฟอร์มเพิ่มวัตถุดิบ',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 15, right: 15, left: 15),
                      child: TextFormField(
                        controller: _controller,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'ชื่อวัตถุดิบ',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          hintText: 'กรุณากรอกชื่อวัตถุดิบ',
                          hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          counterStyle: TextStyle(color: Colors.green),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              final selectedValue =
                              await showProductSuggestions(context, connn);
                              if (selectedValue != null) {
                                _controller.text = selectedValue;
                                _name = selectedValue;
                                _history = selectedValue;
                              }
                            },
                            child: Icon(Icons.history, color: Colors.orange),
                          ),
                        ),
                        onChanged: (value) {
                          if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            // Handle invalid input
                          } else {
                            // Handle valid input
                          }
                          _name = value;
                          _history = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ValueListenableBuilder<String?>(
                      valueListenable: selectedValues,
                      builder: (context, value, child) {
                        return Container(
                          width: 100,
                          height: 40,
                          margin: const EdgeInsets.only(right: 280.0),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 17, top: 0, bottom: 0, right: 0),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            value: value,
                            items: Items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedValues.value = newValue;
                              _description = newValue!;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        initialValue: '',
                        decoration: const InputDecoration(
                          labelText: 'ปริมาณวัตถุดิบ',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          hintText: 'กรุณากรอกปริมาณวัตถุดิบ(กรุณาใส่ตัวเลข)',
                          hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          counterStyle: TextStyle(color: Colors.green),
                        ),
                        onChanged: (value) {
                          _price = double.parse(value);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedValuees,
                          builder: (context, value, child) {
                            return Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 17, top: 0, bottom: 0, right: 0),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                value: value,
                                items: Itemss.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  selectedValuees.value = newValue;
                                  _unti = newValue!;
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedValueees,
                          builder: (context, value, child) {
                            return Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(left: 125.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 16, top: 0, bottom: 0, right: 0),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                value: value,
                                items: Itemsss.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  selectedValueees.value = newValue;
                                  _keep = newValue!;
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(
                        right: 290,
                      ),
                      child: Text('วันหมดอายุ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),

                    /*Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                      child:*/ Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<String?>(
                                valueListenable: _radioValueNotifier,
                                builder: (context, value, child) {
                                  return RadioListTile<String>(
                                    title: const Text(
                                      'ทราบวันหมดอายุ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                    value: 'ทราบวันหมดอายุ',
                                    activeColor: Colors.orange,
                                    groupValue: value,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.orange; // สีเมื่อถูกเลือก
                                      } else {
                                        return Colors
                                            .grey; // สีเมื่อไม่ได้ถูกเลือก
                                      }
                                    }),
                                    onChanged: (String? newValue) {
                                      if (newValue == value) {
                                        _radioValueNotifier.value = null;
                                      } else {
                                        _radioValueNotifier.value = newValue;
                                      }
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4.0,
                                        vertical:
                                        -4.0), // Adjusts the size of the radio button
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                  );
                                },
                              ),
                              ValueListenableBuilder<String?>(
                                valueListenable: _radioValueNotifier,
                                builder: (context, value, child) {
                                  return RadioListTile<String>(
                                    title: const Text(
                                      'ไม่ทราบวันหมดอายุ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: 'ไม่ทราบวันหมดอายุ',
                                    activeColor: Colors.orange,
                                    hoverColor: Colors.black,
                                    groupValue: value,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.orange; // สีเมื่อถูกเลือก
                                      } else {
                                        return Colors
                                            .grey; // สีเมื่อไม่ได้ถูกเลือก
                                      }
                                    }),
                                    onChanged: (String? newValue) {
                                      if (newValue ==
                                          _radioValueNotifier.value) {
                                        _radioValueNotifier.value = null;
                                      } else {
                                        _radioValueNotifier.value = newValue;
                                      }
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4.0,
                                        vertical:
                                        -4.0), // Adjusts the size of the radio button
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        8.0), // Adjusts the padding around the RadioListTile
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: _radioValueNotifier,
                          builder: (context, value, child) {
                            return Container(
                              width: 120,
                              height: 40,
                              margin: const EdgeInsets.only(right: 35.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: value == 'ไม่ทราบวันหมดอายุ'
                                      ? Colors.grey
                                      : Colors.orange,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(2),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(
                                    color: value == 'ไม่ทราบวันหมดอายุ'
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  '${date.day}-${date.month}-${date.year}',
                                  style: TextStyle(
                                    color: value == 'ไม่ทราบวันหมดอายุ'
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: value == 'ไม่ทราบวันหมดอายุ'
                                    ? null
                                    : () async {
                                  final DateTime? dateTime =
                                  await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (dateTime != null) {
                                    _time = dateTime
                                        .toString()
                                        .substring(0, 10);
                                    var d =
                                    int.parse(_time.substring(8, 10));
                                    var m =
                                    int.parse(_time.substring(5, 7));
                                    var y =
                                    int.parse(_time.substring(0, 4));
                                    date = DateTime(y, m, d);

                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: const Text(
                            'เพิ่มวัตถุดิบ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () async {
                            var newProduct = Product(
                                name: _name,
                                description: _description,
                                price: _price,
                                time: _time,
                                favorite: _favorite,
                                keep: _keep,
                                unit: _unti,
                                history: _history);
                            products.add(newProduct);
                            connn.add(_name);
                            await dbHelper.insertProduct(newProduct);
                            Navigator.pop(context, products);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class ModalEditproductForm {
  ModalEditproductForm(
      {Key? key, required this.productDetail, required this.dbHelper});
  String? selectedValue = 'ประเภท';
  var connn = [''];
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String?> _radioValueNotifier =
  ValueNotifier<String?>('ทราบวันหมดอายุ');
  ValueNotifier<String?> selectedValues = ValueNotifier('ประเภท');
  ValueNotifier<String?> selectedValuees = ValueNotifier('หน่วย');
  ValueNotifier<String?> selectedValueees = ValueNotifier('ช่องเก็บ');
  String? selectedValuee = 'หน่วย';
  String? selectedValueee = 'ช่องเก็บ';
  DateTime date = DateTime.now();
  var Items = ['ประเภท', 'เนื้อสัตว์', 'ผัก', 'ไข่','อื่นๆ'];
  var Itemss = [
    'หน่วย',
    'กรัม',
    'กิโลกรัม',
    'หัว',
    'หลอด',
    'ก้อน',
    'เม็ด',
    'ฟอง',
    'ลูก',
    'ใบ',
    'ต้น'
  ];
  var Itemsss = ['ช่องเก็บ', 'ช่องปกติ', 'ช่องฟรีส'];
  Product productDetail;
  DatabaseHelper dbHelper;

  String _name = '', _description = '', _unti = '', _keep = '', _history = '';
  double _price = 0;
  int _favorite = 0;
  String _time = '';
  Future<String?> showProductSuggestions(
      BuildContext context, List<String> suggestions) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('รายการวัตถุดิบที่เคยเก็บ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: suggestions.length * 2 - 1, // Adjusted item count for dividers
              itemBuilder: (BuildContext context, int index) {
                if (index.isOdd) { // Check if index is odd (divider position)
                  return Divider(
                    color: Colors.orange, // Set divider color to black
                  );
                }
                final int suggestionIndex = index ~/ 2; // Calculate actual suggestion index
                return ListTile(
                  title: Text(suggestions[suggestionIndex],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 18)),
                  onTap: () {
                    Navigator.of(context).pop(suggestions[suggestionIndex]);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> showModalInputForm(BuildContext context) {
    _favorite = productDetail.favorite;
    _name = productDetail.name;
    _price = productDetail.price;
    _description = productDetail.description;
    _time = productDetail.time;
    _unti=productDetail.unit;
    _keep=productDetail.keep;
    _history = productDetail.history;

    return showModalBottomSheet(

        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Center(
                    child: Text(
                      'แบบฟอร์มเพิ่มวัตถุดิบ',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 15, right: 15, left: 15),
                      child: TextFormField(
                        controller: _controller,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                          labelText: 'ชื่อวัตถุดิบ',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          hintText: 'กรุณากรอกชื่อวัตถุดิบ',
                          hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          counterStyle: TextStyle(color: Colors.green),
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              final selectedValue =
                              await showProductSuggestions(context, connn);
                              if (selectedValue != null) {
                                _controller.text = selectedValue;
                                _name = selectedValue;
                                _history = selectedValue;
                              }
                            },
                            child: Icon(Icons.history, color: Colors.orange),
                          ),
                        ),
                        onChanged: (value) {
                          if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]')
                              .hasMatch(value)) {
                            // Handle invalid input
                          } else {
                            // Handle valid input
                          }
                          _name = value;
                          _history = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    ValueListenableBuilder<String?>(
                      valueListenable: selectedValues,
                      builder: (context, value, child) {
                        return Container(
                          width: 100,
                          height: 40,
                          margin: const EdgeInsets.only(right: 280.0),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.orange, width: 1.0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 17, top: 0, bottom: 0, right: 0),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            value: value,
                            items: Items.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              selectedValues.value = newValue;
                              _description = newValue!;
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),

                        decoration: const InputDecoration(
                          labelText: 'ปริมาณวัตถุดิบ',
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          hintText: 'กรุณากรอกปริมาณวัตถุดิบ(กรุณาใส่ตัวเลข)',
                          hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(10)),
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                          counterStyle: TextStyle(color: Colors.green),
                        ),
                        onChanged: (value) {
                          _price = double.parse(value);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedValuees,
                          builder: (context, value, child) {
                            return Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(left: 15.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 17, top: 0, bottom: 0, right: 0),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                value: value,
                                items: Itemss.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  selectedValuees.value = newValue;
                                  _unti = newValue!;
                                },
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: selectedValueees,
                          builder: (context, value, child) {
                            return Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(left: 125.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.orange, width: 1.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 16, top: 0, bottom: 0, right: 0),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                value: value,
                                items: Itemsss.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  selectedValueees.value = newValue;
                                  _keep = newValue!;
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(
                        right: 290,
                      ),
                      child: Text('วันหมดอายุ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),

                    /*Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 5),
                      child:*/ Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ValueListenableBuilder<String?>(
                                valueListenable: _radioValueNotifier,
                                builder: (context, value, child) {
                                  return RadioListTile<String>(
                                    title: const Text(
                                      'ทราบวันหมดอายุ',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16),
                                    ),
                                    value: 'ทราบวันหมดอายุ',
                                    activeColor: Colors.orange,
                                    groupValue: value,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.orange; // สีเมื่อถูกเลือก
                                      } else {
                                        return Colors
                                            .grey; // สีเมื่อไม่ได้ถูกเลือก
                                      }
                                    }),
                                    onChanged: (String? newValue) {
                                      if (newValue == value) {
                                        _radioValueNotifier.value = null;
                                      } else {
                                        _radioValueNotifier.value = newValue;
                                      }
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4.0,
                                        vertical:
                                        -4.0), // Adjusts the size of the radio button
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8.0),
                                  );
                                },
                              ),
                              ValueListenableBuilder<String?>(
                                valueListenable: _radioValueNotifier,
                                builder: (context, value, child) {
                                  return RadioListTile<String>(
                                    title: const Text(
                                      'ไม่ทราบวันหมดอายุ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: 'ไม่ทราบวันหมดอายุ',
                                    activeColor: Colors.orange,
                                    hoverColor: Colors.black,
                                    groupValue: value,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>((states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return Colors.orange; // สีเมื่อถูกเลือก
                                      } else {
                                        return Colors
                                            .grey; // สีเมื่อไม่ได้ถูกเลือก
                                      }
                                    }),
                                    onChanged: (String? newValue) {
                                      if (newValue ==
                                          _radioValueNotifier.value) {
                                        _radioValueNotifier.value = null;
                                      } else {
                                        _radioValueNotifier.value = newValue;
                                      }
                                    },
                                    visualDensity: VisualDensity(
                                        horizontal: -4.0,
                                        vertical:
                                        -4.0), // Adjusts the size of the radio button
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal:
                                        8.0), // Adjusts the padding around the RadioListTile
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder<String?>(
                          valueListenable: _radioValueNotifier,
                          builder: (context, value, child) {
                            return Container(
                              width: 120,
                              height: 40,
                              margin: const EdgeInsets.only(right: 35.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: value == 'ไม่ทราบวันหมดอายุ'
                                      ? Colors.grey
                                      : Colors.orange,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(2),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(
                                    color: value == 'ไม่ทราบวันหมดอายุ'
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  '${date.day}-${date.month}-${date.year}',
                                  style: TextStyle(
                                    color: value == 'ไม่ทราบวันหมดอายุ'
                                        ? Colors.grey
                                        : Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: value == 'ไม่ทราบวันหมดอายุ'
                                    ? null
                                    : () async {
                                  final DateTime? dateTime =
                                  await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(1940),
                                    lastDate: DateTime(2100),
                                  );
                                  if (dateTime != null) {
                                    _time = dateTime
                                        .toString()
                                        .substring(0, 10);
                                    var d =
                                    int.parse(_time.substring(8, 10));
                                    var m =
                                    int.parse(_time.substring(5, 7));
                                    var y =
                                    int.parse(_time.substring(0, 4));
                                    date = DateTime(y, m, d);

                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: const Text(
                            'เเก้ไขวัตถุดิบ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () async{
                            var newProduct = Product(
                                name: _name,
                                description: _description,
                                price: _price,
                                time: _time,
                                favorite: _favorite,
                                keep: _keep,
                                unit: _unti,
                                history: _history);

                            await dbHelper.updateProduct(newProduct);
                            Navigator.pop(context, newProduct);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

// ** #Edit Add ModalEditProductForm here !!!

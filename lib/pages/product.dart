
import 'package:flutter/material.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/pages/Warning.dart';
import 'package:untitled/pages/home.dart';
import 'package:sqflite/sqflite.dart';
import '../database/model.dart';
import 'package:untitled/pages/searh.dart';
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
    Future<dynamic>_showConfirmDalog(BuildContext context,String action){
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder:(BuildContext context){
            return AlertDialog(
              title:Text ('Do you want to $action this item?'),
              actions: [ElevatedButton(onPressed: (){Navigator.pop(context,true);},
                  child: const Text('Yse')),
              ElevatedButton(onPressed:(){Navigator.pop(context,false);},
                  child: const Text('No'))
              ],
            );
          }
      );
    }
    var ttime=DateTime.now().toString();
    var d2= int.parse(ttime.substring(8,10));
    var mm= int.parse(ttime.substring(5,7));
    var yy= int.parse(ttime.substring(0,4));

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            IconButton(

              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(products: widget.products,dbHelper: widget.dbHelper,)),);
              },
            ),
            IconButton(
              icon: Icon(Icons.backup_table),
              onPressed: () {

              },
            ),
            IconButton(
              icon: Icon(Icons.add_alert),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Warning(products: widget.products,dbHelper: widget.dbHelper,)),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [

          IconButton(
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
          ),
          IconButton(
              color: Colors.white,
              iconSize: 35.0,
              hoverColor: Colors.white70,
              onPressed: ()  {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=>SearchProduct(products: widget.products,dbHelper: widget.dbHelper,)
                    ),
                );
              },
              icon: const Icon(Icons.search)
          ),


         // Text('Add product',),
           Text('      ',)
        ],

        title: const Text('Composition',style:TextStyle(color: Colors.black,) ),
        centerTitle: false,
        backgroundColor: Colors.orange[300],
      ),
      body: ListView.separated(separatorBuilder:  (context, index) {//<-- SEE HERE
        return Divider(
          thickness: 1,

        );
      },
        padding: EdgeInsets.all(8),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          // ** Edit ** Wrap this Card with Dismissible widget for swipable
          return Dismissible(
            key: UniqueKey(),
            background: Container(color:Colors.blue),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 30),
              child: const Icon(Icons.delete_outlined,color: Colors.white,size: 30),
            ),

            onDismissed: (direction){
              String prodductdeleted = widget.products[index].name;
              if(direction==DismissDirection.endToStart){

               widget.dbHelper.deleteProduct(widget.products[index].name);
              }
              setState(() {widget.products.removeAt(index);});
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('$prodductdeleted is deleted')));

            },
            confirmDismiss: (direction) async {
              if(direction==DismissDirection.endToStart){
                return await _showConfirmDalog(context, 'Delete');
              }
              return false;
          },

            direction: DismissDirection.horizontal,

            child: ListTile(

              visualDensity: VisualDensity(vertical: 0),

              tileColor: Colors.amber[100],
              contentPadding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(width: 2,color: Colors.brown),),
              title: Text(widget.products[index].name,style: TextStyle(fontSize: 20)),
              subtitle:
              Text('quantity: ${widget.products[index].price.toString()}'+' Date: ${widget.products[index].time.toString()}'+' Type: ${widget.products[index].description.toString()}'),

                trailing: d2>int.parse(widget.products[index].time.substring(8,10))
                  ? const Icon(Icons.access_time, color: Colors.red)
                  : const Icon(Icons.access_time, color: Colors.green),
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(productdetail: widget.products[index], dbHelper: widget.dbHelper),
                  ),
                );
                setState(() {
                  if (result != null) {
                    widget.products[index].favorite = result;
                    widget.dbHelper.updateProduct(widget.products[index]);
                    // ** Edit : Call update method here (for favorite flag)
                  }
                });
              },
              onLongPress:() async{
                var result = await ModalEditproductForm(
                    productDetail: widget.products[index],
                    dbHelper: widget.dbHelper).showModalInputForm(context);
                setState(() {
                  if(result!=null){
                    widget.products[index]=result;
                  }
                });
              },
            ),

          );

        },

      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.productdetail,required this.dbHelper}) : super(key: key);
  final DatabaseHelper dbHelper;
  final Product productdetail;

  @override
  Widget build(BuildContext context) {
    var result = productdetail.favorite;
    //var d= int.parse(productdetail.time.toString());
    return Scaffold(
      appBar: AppBar(
        //if(d<1){}
      backgroundColor: Colors.orange[300],
        title: Text(productdetail.name,style: TextStyle(fontSize: 25,color: Colors.black)),
      ),
      body: Column(

        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('Type: '+productdetail.description,style: TextStyle(fontSize: 17,color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('quantity: ${productdetail.price.toString()}',style: TextStyle(fontSize: 17,color: Colors.black)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10, top: 20.0),
            child: Text('Date: ${productdetail.time}',style: TextStyle(fontSize: 17 ,color: Colors.black)),
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
                  child: const Text('Delete'),
                  onPressed: () {

                    Navigator.pop(context, result);
                  },
                ),
                ElevatedButton(
                  child: const Text('Edic'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 40),
                  ),
                  onPressed: () async{
                    Product it = Product(name: productdetail.name, description: productdetail.description, price: productdetail.price, time: productdetail.time, favorite: productdetail.favorite);
                    result = await ModalEditproductForm(
                        productDetail: it,
                        dbHelper: dbHelper).showModalInputForm(context);
                    Navigator.pop(context, result);
                  },
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 40),
                  ),
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


class ModalProductForm  {
  ModalProductForm({Key? key, required this.products, required this.dbHelper});
  String? selectedValue = 'ประเภท';
  DateTime date = DateTime.now();
  var Items = ['ประเภท','เนื้อสัตว์', 'ผัก', 'ไข่','อื่นๆ'];
  List<Product> products;
  DatabaseHelper dbHelper;


// List of items in our dropdown menu
  String _name = '', _description = '';
  double _price = 0;
  final int _favorite = 0;
  String _time='';
  Future<dynamic> showModalInputForm(BuildContext context) {
    return showModalBottomSheet(
        //backgroundColor: Colors.yellow ,
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
                      'Composition input Form',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        initialValue: '',
                        autofocus: true,
                        validator: ((value){
                          if(value!.startsWith('.')){return 'no.';}
                          if(value.trim().isEmpty){return 'pl';}
                          return null;
                        }
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Composition Name',
                          hintText: 'input your name of composition',

                        ),
                        onChanged: (value) {
                          _name = value;

                        },
                      ),
                    ),

                      DropdownButton(
                        padding:EdgeInsets.only(right: 300.0) ,
                        // Initial Value
                        value: selectedValue,
                        // Down Arrow Icon

                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: Items.map((String Items) {
                          return DropdownMenuItem(
                            value: Items,
                            child: Text(Items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          selectedValue = newValue!;
                            _description = newValue!;

                        },

                      ),

                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
    validator: (value) {
    if (value == null) {
    return 'Please select gender.';
    }},
                        initialValue: '',

                        decoration: const InputDecoration(
                          labelText: 'quantity',
                          hintText: 'input quantity',
                        ),
                        onChanged: (value) {
                          _price = double.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      padding:EdgeInsets.only(right: 300.0) ,
                      child: Text('${date.day}-${date.month}-${date.year}'),
                    ),
                    Container(
                      padding:EdgeInsets.only(right: 280.0) ,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,),
                        child: const Text('Choose Date'),
                        onPressed: () async{
                          final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1940),
                              lastDate: DateTime(2100),
                          );
                          _time=dateTime.toString().substring(0,10);
                          var d= int.parse(_time.substring(8,10));
                          var m= int.parse(_time.substring(5,7));
                          var y= int.parse(_time.substring(0,4));
                          date=date.copyWith(day:d,month:m,year:y);
                        },

                      ),

                    ),


                    Container(
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
                          child: const Text('Add'),
                          onPressed: () async {
                            var newProduct = Product(
                                name: _name,
                                description: _description,
                                price: _price,
                                time: _time,
                                favorite: _favorite);
                            products.add(newProduct);
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
  ModalEditproductForm({Key? key, required this.productDetail, required this.dbHelper});
  String? selectedValue = 'ประเภท';
  DateTime date = DateTime.now();
  var Items = ['ประเภท','เนื้อสัตว์', 'ผัก', 'ไข่','อื่นๆ'];

  Product productDetail;
  DatabaseHelper dbHelper;

  String _name = '', _description = '';
  double _price = 0;
  int _favorite = 0;
  String _time='';

  Future<dynamic> showModalInputForm(BuildContext context) {
    _favorite=productDetail.favorite;
    _name=productDetail.name;
    _price=productDetail.price;
    _description=productDetail.description;
    _time=productDetail.time;
    return showModalBottomSheet(

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
                      'Composition input Form',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: productDetail.name,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Composition Name',
                          hintText: 'input your name of Composition',
                        ),
                        onChanged: (value) {

                        },
                      ),
                    ),
                    DropdownButton(
                      padding:EdgeInsets.only(right: 300.0) ,
                      // Initial Value
                      value: selectedValue,


                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: Items.map((String Items) {
                        return DropdownMenuItem(
                          value: Items,
                          child: Text(Items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        selectedValue = newValue!;
                        _description = newValue!;


                      },

                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        initialValue: productDetail.price.toString(),
                        decoration: const InputDecoration(
                          labelText: 'quantity',
                          hintText: 'input quantity',
                        ),
                        onChanged: (value) {
                          _price = double.parse(value);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: TextFormField(
                        initialValue: productDetail.time.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          hintText: 'input Time',
                        ),
                        onChanged: (value) {
                          _time = value;
                        },
                      ),
                    ),
                    Container(
                      padding:EdgeInsets.only(right: 280.0) ,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,),
                        child: const Text('Choose Date'),
                        onPressed: () async{
                          final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime(1940),
                            lastDate: DateTime(2100),
                          );
                          _time=dateTime.toString().substring(0,10);
                          var d= int.parse(_time.substring(8,10));
                          var m= int.parse(_time.substring(5,7));
                          var y= int.parse(_time.substring(0,4));
                          date=date.copyWith(day:d,month:m,year:y);
                        },

                      ),

                    ),


                    Container(
                      margin: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          child: const Text('update'),
                          onPressed: () async {
                            var newProduct = Product(
                                name: _name,
                                description: _description,
                                price: _price,
                                time: _time,
                                favorite: _favorite);

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

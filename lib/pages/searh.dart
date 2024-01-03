
import 'package:flutter/material.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/database/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/pages/product.dart';

// ignore: must_be_immutable
class SearchProduct extends StatefulWidget {
  SearchProduct({Key? key, required this.products, required this.dbHelper}) : super(key: key);
  DatabaseHelper dbHelper;
  List<Product> products;
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String _searchValue = '';
  List<Product> resultProducts = [];
  String _selectedCategory = 'All'; // Default value
  List<String> categories = ['All', 'Category1', 'Category2', 'Category3']; // Add your own categories


  bool found = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(

          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              onChanged: (value) => _searchValue = value,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () async {

                      var result = await widget.dbHelper.Products(_searchValue);
                      resultProducts.clear();
                      for (var i =0;i<result.length;i++){
                        resultProducts.add(result[i]);
                      setState(() {
                      });}
                    },
                  ),

                  hintText: 'Search...',
                  border: InputBorder.none),
            ),

          ),

        ),

      ),

      body: buildFoundList()

    );
  }

  Widget buildFoundList() {
    return ListView.builder(
        itemCount: resultProducts.length,
        itemBuilder: (context, index) {
          return Card(

              child: ListTile(
                title: Text('Name: ${resultProducts[index].name}'),
                subtitle: Text(
                    'Description:  ${resultProducts[index].description}/ Price: ${resultProducts[index].price}'),
                onTap: ()async{var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(productdetail: widget.products[index],dbHelper: widget.dbHelper),
                  ),
                );},
              ));
        });
  }
}

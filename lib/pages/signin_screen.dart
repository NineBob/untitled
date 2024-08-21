import 'package:untitled/pages/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/pages/Dashboard.dart';
import '../database/model.dart';
import 'package:untitled/database/database_helper.dart';
import 'package:untitled/pages/product.dart';
import 'package:untitled/src/recipes/presentation/screens/home_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/src/recipes/presentation/screens/fool_show.dart';
import 'package:untitled/src/onboarding/widgets/onboarding_screen_widgets.dart';
import 'package:untitled/pages/sum.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required this.products, required this.dbHelper})
      : super(key: key);

  List<Product> products;
  DatabaseHelper dbHelper;
  @override
  _maue createState() => _maue();
}

class _maue extends State<SignInScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  List<String> popo = [];
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    calculatePopo();
  }

  void calculatePopo() {
    popo.clear();
    var ttime = DateTime.now().toString();
    var d2 = int.parse(ttime.substring(8, 10));
    var mm = int.parse(ttime.substring(5, 7));
    var yy = int.parse(ttime.substring(0, 4));
    int ddd = d2 + (mm * 30);
    int dddd = (d2 + (mm * 30)) + 3;
    for (int i = 0; i < widget.products.length; i++) {
      if (dddd >
          (int.parse(widget.products[i].time.substring(8, 10)) +
              (int.parse(widget.products[i].time.substring(5, 7)) * 30))) {
        setState(() {
          popo.add(widget.products[i].name);
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    print(popo);
    calculatePopo();
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const SizedBox(width: 95),
          Text('ตู้เย็นของฉัน',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Schyler',
              )),

        ]),
        toolbarHeight: 80,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      /*bottomNavigationBar: ConvexAppBar(
        curveSize: 100,
        elevation: 5,
        height: 70,
        items: [
          TabItem(icon: Icons.book_outlined, title: 'สูตรอาหาร'),
          TabItem(icon: Icons.backup_table, title: 'วัตถุดิบ'),
          TabItem(icon: Icons.home, title: 'เมนู'),
          TabItem(icon: Icons.add_chart, title: 'เเดชบอร์ด'),
          TabItem(icon: Icons.star_purple500_sharp, title: 'สูตรเเนะนำ'),
        ],
        gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.orange]
        ),
        initialActiveIndex: 2,
        //optional, default as 0
        onTap: (val) {

        },
      ),*/
      body: SafeArea(
        child: Container(
          margin:
              const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 15),
          padding: EdgeInsets.only(top: 0, right: 10, left: 10),
          /*decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'MyFridge',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),*/
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0), // กำหนดระยะห่างด้านบนของ title
                        child: Row(children: [
                          const SizedBox(width: 5),
                          Text(
                            'วัตถุดิบที่ใกล้หมดอายุ',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontFamily: 'Schyler',
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.red,
                            size: 32,
                          )
                        ])),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [],
                      ),
                      height: 55,
                      child: Scrollbar(
                        thickness: 4.0,
                        thumbVisibility: true,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 6.0, top: 6), // ระยะห่างจากด้านบน 8.0
                          child: popo.isEmpty
                              ? Center(
                                  child: Text(
                                    'ไม่พบวัตถุดิบใกล้หมดอายุ',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: popo.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Listt(
                                        namep: popo[index],
                                        dt: widget.products[index].time,
                                        dbHelper: widget.dbHelper,
                                        products: widget.products,
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ),

                    /*const Center(
                      child: Text(
                        'เมนู',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                    ),*/
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  products: widget.products,
                                  dbHelper: widget.dbHelper,
                                ),
                              ),
                            );
                          },
                          icon: "assets/refrigerators.png",
                          title: 'จัดการวัตถุดิบในตู้เย็น',
                          color: Colors.orange.shade400,
                          fontColor: Colors.white,
                        ),
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                          icon: 'assets/restaurant.png',
                          title: 'สูตรอาหาร',
                          color: Colors.orange.shade400,
                          fontColor: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreenfool(products: widget.products),
                              ),
                            );
                          },
                          color: Colors.orange.shade400,
                          icon: 'assets/hat-chef.png',
                          title: 'สูตรอาหารที่พร้อมทำ',
                          fontColor: Colors.white,
                        ),
                        _cardMenu(
                          onTap: () {
                            _launchURL();
                          },
                          color: Colors.orange.shade400,
                          icon: 'assets/site-alt.png',
                          title: 'เพิ่มสูตรอาหาร',
                          fontColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(
          autoPlay: false,
          controller: _controller,
        )
        .blurXY(begin: 0, end: 25, duration: 600.ms, curve: Curves.easeInOut)
        .scaleXY(begin: 1, end: 0.6)
        .fadeOut(
          begin: 1,
        );
  }

  Widget _cardMenu({
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
        ),
        width: 170,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.white)
          ],
        ),
        child: Column(
          children: [
            Image.asset(icon),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    const url =
        'https://3d52-27-55-69-72.ngrok-free.app';
    final encodedUrl = Uri.encodeFull(url);
    final uri = Uri.parse(encodedUrl);
    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: 'chrome');
    } else {
      throw 'Could not launch $encodedUrl';
    }
  }
}

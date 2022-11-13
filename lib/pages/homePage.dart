import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_catalogue/modals/cart.dart';
import 'package:movie_catalogue/modals/catalog.dart';
import 'package:movie_catalogue/pages/productDetail.dart';
import 'package:movie_catalogue/pages/shoppingCart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    var jsonData = await rootBundle.loadString("assets/files/catalog.json");
    var decodeData = await jsonDecode(jsonData);
    List products = decodeData["products"];
    Products.list =
        products.map<Products>((item) => Products.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Catalogue App"),
      // ),
      floatingActionButton: Stack(children: [
        FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoppingCartPage()));
          },
          child: Icon(CupertinoIcons.shopping_cart),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Consumer<CartModal>(
                builder: (context, cart, _) {
                  return Text(
                      cart.cartList.length > 0
                          ? cart.cartList.length.toString()
                          : "0",
                      style: TextStyle(color: Colors.white, fontSize: 17));
                },
              )),
        )
      ]),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: (Products.list.length > 0)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Catalog App",
                        style:
                            TextStyle(color: Colors.deepPurple, fontSize: 30),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Products.list.length,
                          itemBuilder: (context, index) {
                            final Products item = Products.list[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetail(
                                                    product:
                                                        Products.list[index],
                                                  )));
                                    },
                                    child: Container(
                                        child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Container(
                                              color: Color(0xfff5f5f5),
                                              padding: EdgeInsets.all(16),
                                              child: Hero(
                                                tag: item.id,
                                                child: Image.network(
                                                  item.image,
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                item.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: _width * 0.47,
                                                child: Text(
                                                  item.desc,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                // color: Colors.green,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "\$${item.price.toString()}",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.deepPurple,
                                                          fontSize: 17),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15),
                                                    Consumer<CartModal>(builder:
                                                        (context, cart, child) {
                                                      return AnimatedContainer(
                                                        duration: Duration(
                                                            seconds: 1),
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15))),
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors
                                                                            .deepPurple)),
                                                            onPressed: () {
                                                              if (!cart
                                                                  .checkItemInCart(
                                                                      item))
                                                                cart.addItem(
                                                                    item);
                                                            },
                                                            child: (cart
                                                                    .checkItemInCart(
                                                                        item))
                                                                ? Icon(CupertinoIcons
                                                                    .check_mark)
                                                                : Icon(CupertinoIcons
                                                                    .cart_badge_plus)),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       right: 12.0),
                                        //   child: Column(
                                        //     children: [
                                        //       Text(
                                        //         "\$${item.price.toString()}",
                                        //         style: TextStyle(
                                        //             color: Colors.red,
                                        //             fontSize: 17),
                                        //       ),
                                        //       Consumer<CartModal>(builder:
                                        //           (context, cart, child) {
                                        //         return AnimatedContainer(
                                        //           duration:
                                        //               Duration(seconds: 1),
                                        //           child: IconButton(
                                        //               onPressed: () {
                                        //                 if (!cart
                                        //                     .checkItemInCart(
                                        //                         item))
                                        //                   cart.addItem(item);
                                        //               },
                                        //               icon: (cart
                                        //                       .checkItemInCart(
                                        //                           item))
                                        //                   ? Icon(CupertinoIcons
                                        //                       .check_mark)
                                        //                   : Icon(CupertinoIcons
                                        //                       .cart_badge_plus)),
                                        //         );
                                        //       })
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    )),
                                  )),
                            );
                          }),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.7639333);
    path_0.quadraticBezierTo(size.width * 0.2162667, size.height * 1.0201000,
        size.width * 0.4985333, size.height * 0.9999333);
    path_0.quadraticBezierTo(size.width * 0.8630000, size.height * 1.0212000,
        size.width, size.height * 0.7641667);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

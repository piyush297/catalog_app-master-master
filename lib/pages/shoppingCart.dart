import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_catalogue/modals/cart.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Buying Not Supported Yet")));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "Pay Now",
                style: TextStyle(fontSize: 18),
              ),
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Check Out",
                style: TextStyle(color: Colors.deepPurple, fontSize: 30),
              ),
            ),
            Expanded(
              child: Consumer<CartModal>(builder: (context, cart, child) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.cartList.length,
                    itemBuilder: (context, index) {
                      final item = cart.cartList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                                Text(
                                  ("\$${item.price.toString()}"),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 17),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cart.removeItem(item);
                                    },
                                    icon: Icon(CupertinoIcons.cart_badge_minus))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Amount: ", style: TextStyle(fontSize: 20)),
                  Consumer<CartModal>(builder: (context, cart, child) {
                    return Text(
                      "\$${cart.totalPrice.toString()}",
                      style: TextStyle(fontSize: 21, color: Colors.green),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

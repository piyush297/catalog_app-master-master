import 'package:flutter/material.dart';
import 'package:movie_catalogue/modals/cart.dart';
import 'package:movie_catalogue/pages/homePage.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final product;
  ProductDetail({Key? key, @required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Details"),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${widget.product.price.toString()}",
              style: TextStyle(color: Colors.red, fontSize: 25),
            ),
            Consumer<CartModal>(
              builder: (context, cart, _) {
                return ElevatedButton(
                    onPressed: () {
                      if (!cart.checkItemInCart(widget.product))
                        cart.addItem(widget.product);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    child: (cart.checkItemInCart(widget.product)
                        ? Text("Already added")
                        : Text("Buy")));
              },
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: EdgeInsets.symmetric(horizontal: 32),
              color: Color(0xfff5f5f5),
              child: Hero(
                  tag: widget.product.id,
                  child: Image.network(
                    widget.product.image,
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.product.name,
            style: TextStyle(fontSize: 36),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.product.desc,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ))),
    );
  }
}

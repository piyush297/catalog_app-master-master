import 'package:flutter/cupertino.dart';
import 'package:movie_catalogue/modals/catalog.dart';

class CartModal extends ChangeNotifier {
  List<Products> cartList = [];

  void addItem(Products product) {
    cartList.add(product);
    notifyListeners();
  }

  void removeItem(Products product) {
    cartList.remove(product);
    notifyListeners();
  }

  num get totalPrice {
    num price = 0;
    cartList.forEach((item) {
      price += item.price;
    });
    return price;
  }
  
  bool checkItemInCart(Products item){
    if(cartList.contains(item))
      return true;
    else
      return false;
  }
}

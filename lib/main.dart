import 'package:flutter/material.dart';
import 'package:movie_catalogue/modals/cart.dart';
import 'package:movie_catalogue/pages/homePage.dart';
import 'package:provider/provider.dart';

main(List<String> args) {
  runApp(ChangeNotifierProvider(
    create: (context) => CartModal(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black),
              textTheme: TextTheme(headline6: TextStyle(color: Colors.black)))),
    );
  }
}

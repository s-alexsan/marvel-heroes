import 'package:flutter/material.dart';
import 'package:marvel_heroes/view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xfff2264b),
        appBarTheme: const AppBarTheme(elevation: 0, color: Color(0xffffffff), centerTitle: true),
        backgroundColor: const Color(0xffffffff),
        primarySwatch: Colors.blue,
        fontFamily: "gilroy",
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

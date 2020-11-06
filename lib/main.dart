import 'package:flutter/material.dart';
import './wrapper.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HexPay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.black87,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange[200]),
                  borderRadius: BorderRadius.circular(10))),
      ),
      home: Wrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
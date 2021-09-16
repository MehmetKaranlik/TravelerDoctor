import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/login_ekrani.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginEkrani(),
      theme: lightTheme(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          disabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(width: 150, color: Colors.white)),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.white),
          ),
          // labelText: "Log-in",
          hintStyle: TextStyle(color: Colors.blue),
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
          ),
        ));
  }
}

import 'package:barbers/page/home.dart';
import 'package:barbers/util/main_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MainColors.getMatColor(MainColors.primary_w500),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(color: MainColors.black),
          backgroundColor: MainColors.white,
        ),
      ),
      home: HomePage(),
    );
  }
}

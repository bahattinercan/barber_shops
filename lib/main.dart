// ignore_for_file: deprecated_member_use
import 'package:barbers/pages/start.dart';
import 'package:barbers/utils/main_colors.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Berberim',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: MainColors.new_secondary,
          primaryVariant: MainColors.new_seconday_variant,
          secondary: MainColors.new_secondary,
          secondaryVariant: MainColors.new_seconday_variant,
        ),
        primarySwatch: MainColors.secondary_mat,
        accentColor: MainColors.new_seconday_variant,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          toolbarHeight: 75,
        ),
        // appBarTheme: AppBarTheme(
        //   elevation: 0,
        //   color: Colors.transparent,
        //   actionsIconTheme: IconThemeData(color: MainColors.black),
        //   iconTheme: IconThemeData(color: MainColors.black),
        //   // toolbarTextStyle: text.bodyText2,
        //   titleTextStyle: TextStyle(
        //     color: MainColors.black,
        //     fontWeight: FontWeight.w700,
        //     fontSize: 20,
        //   ),
        //   toolbarHeight: 75,
        // ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ButtonStyle(
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        //     ),
        //   ),
        // ),
        // cardTheme: CardTheme(
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        // colorScheme: ColorScheme.light(
        //   primary: MainColors.primary_w900,
        //   primaryVariant: MainColors.primary_w900,
        //   secondary: MainColors.primary_w500,
        //   secondaryVariant: MainColors.primary_w900,
        // ),
        // primarySwatch: MainColors.getMatColor(MainColors.primary_w900),
        // accentColor: MainColors.getMatColor(MainColors.primary_w900),
        // dialogTheme: DialogTheme(
        //   titleTextStyle: TextStyle(color: MainColors.black),
        //   backgroundColor: MainColors.white,
        // ),
        // textButtonTheme:
        //     TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(MainColors.black))),
      ),
      home: StartPage(),
    );
  }
}

// ignore_for_file: deprecated_member_use
import 'package:barbers/pages/general/start.dart';
import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Berberim',
      theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Colorer.primary,
            primaryVariant: Colorer.primaryVariant,
            secondary: Colorer.secondary,
            secondaryVariant: Colorer.secondaryVariant,
            background: Colorer.background,
            surface: Colorer.onSurface,
            onBackground: Colorer.onBackground,
            onSurface: Colorer.onSurface,
            onPrimary: Colorer.onPrimary,
            onSecondary: Colorer.onSecondary,
            brightness: Brightness.dark,
            error: Colors.red,
            onError: Colors.white,
          ),
          primaryColor: Colorer.primary,
          primarySwatch: Colorer.getMatColor(Colorer.primary),
          accentColor: Colorer.getMatColor(Colorer.secondary),
          // WIDGETS
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            toolbarHeight: 75,
            iconTheme: IconThemeData(
              color: Colorer.onBackground,
            ),
            titleTextStyle: TextStyle(
              color: Colorer.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          scaffoldBackgroundColor: Colorer.background,
          cardTheme: const CardTheme(
            color: Colorer.surface,
            elevation: 0,
          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: Colorer.surface,
          ),
          // BUTTONS
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colorer.primary;
                  }
                  return Colorer.onSecondary;
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colorer.surface;
                  }
                  return Colorer.secondary;
                },
              ),
            ),
          ),
          // NAV BARS
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colorer.surface,
            unselectedItemColor: Colorer.onBackground,
            selectedItemColor: Colorer.primaryVariant,
          ),
          // BOTTOM SHEET
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colorer.background,
          ),
          dropdownMenuTheme: const DropdownMenuThemeData(
            menuStyle: MenuStyle(),
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colorer.surface;
                }
                return Colorer.onSurface;
              },
            ),
          ),
          timePickerTheme: const TimePickerThemeData(
            backgroundColor: Colorer.background,
          )),
      home: const StartPage(),
    );
  }
}

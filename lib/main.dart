// ignore_for_file: deprecated_member_use
import 'package:barbers/pages/general/start.dart';
import 'package:barbers/utils/color_manager.dart';
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
          colorScheme: ColorScheme(
            primary: ColorManager.primary,
            primaryVariant: ColorManager.primaryVariant,
            secondary: ColorManager.secondary,
            secondaryVariant: ColorManager.secondaryVariant,
            background: ColorManager.background,
            surface: ColorManager.onSurface,
            onBackground: ColorManager.onBackground,
            onSurface: ColorManager.onSurface,
            onPrimary: ColorManager.onPrimary,
            onSecondary: ColorManager.onSecondary,
            brightness: Brightness.dark,
            error: Colors.red,
            onError: Colors.white,
          ),
          primaryColor: ColorManager.primary,
          primarySwatch: ColorManager.getMatColor(ColorManager.primary),
          accentColor: ColorManager.getMatColor(ColorManager.secondary),
          // WIDGETS
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            toolbarHeight: 75,
            iconTheme: IconThemeData(
              color: ColorManager.onBackground,
            ),
            titleTextStyle: TextStyle(
              color: ColorManager.onBackground,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          scaffoldBackgroundColor: ColorManager.background,
          cardTheme: CardTheme(
            color: ColorManager.surface,
            elevation: 0,
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: ColorManager.surface,
          ),
          // BUTTONS
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ColorManager.primary;
                  }
                  return ColorManager.onSecondary;
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return ColorManager.surface;
                  }
                  return ColorManager.secondary;
                },
              ),
            ),
          ),
          // NAV BARS
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: ColorManager.surface,
            unselectedItemColor: ColorManager.onBackground,
            selectedItemColor: ColorManager.primaryVariant,
          ),
          // BOTTOM SHEET
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ColorManager.background,
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(),
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return ColorManager.surface;
                }
                return ColorManager.onSurface;
              },
            ),
          ),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: ColorManager.background,
          )),
      home: StartPage(),
    );
  }
}

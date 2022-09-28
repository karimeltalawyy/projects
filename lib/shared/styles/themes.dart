import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_one/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  fontFamily: 'Inter',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      elevation: 22.0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0.0,
      color: HexColor('333739'),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: HexColor('333739'),
      )),
);
ThemeData lightTheme = ThemeData(
  fontFamily: 'Inter',
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  primarySwatch: defaultColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
  ),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0.0,
      color: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      )),
);

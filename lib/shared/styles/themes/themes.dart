import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primarySwatch: Colors.deepOrange,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      height: 1.2,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Satoshi',
    ),
    subtitle1: TextStyle(
      height: 1.2,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'Satoshi',
    ),
  ),
  fontFamily: 'Satoshi',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.black12,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
  ),

);
ThemeData lightTheme = ThemeData(
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      height: 1.2,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'Satoshi',
    ),
    subtitle1: TextStyle(
      height: 1.2,
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontFamily: 'Satoshi',
    ),
  ),
  fontFamily: 'Satoshi',
  primarySwatch: Colors.deepOrange,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,
  ),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22.0,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
);

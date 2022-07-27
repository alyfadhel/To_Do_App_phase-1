import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  backgroundColor: Colors.white,
  tabBarTheme:  TabBarTheme(
    labelColor: Colors.black,
    labelStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12.0,
    ),
    unselectedLabelColor: Colors.grey[350],
    overlayColor: MaterialStateProperty.all(
      Colors.black
    )
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme:  IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
);
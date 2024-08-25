import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  primarySwatch: Colors.orange,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Color(0xFFb27409), // Button text color
      padding: EdgeInsets.symmetric(vertical: 16.0),
      minimumSize: Size(double.infinity, 50),
    ),
  ),
  // Add other theme properties as needed
);

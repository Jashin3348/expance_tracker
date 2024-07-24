import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
var kColorScheme= ColorScheme.fromSeed(seedColor:Color.fromARGB(255, 196, 96, 136));
void main() {
  runApp(
    MaterialApp(
     theme: ThemeData().copyWith(
     colorScheme: kColorScheme,
     appBarTheme:const AppBarTheme().copyWith(backgroundColor: kColorScheme.onPrimaryContainer,
     foregroundColor: kColorScheme.primaryContainer),
     cardTheme:const CardTheme().copyWith(
      color: kColorScheme.secondaryContainer,
      margin:const
       EdgeInsets.symmetric(horizontal: 16,vertical: 8),
     ),
     elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer
     )),
     textTheme: ThemeData().textTheme.copyWith(titleLarge: TextStyle(fontWeight: FontWeight.bold,font
     color: kColorScheme.onSecondaryContainer,fontSize: 15))
     ), 

      home:const Expenses(),
    ),
  );
}

import 'package:flutter/material.dart';

const Color bluishClr =Color(0xFF4e5ae8);
const Color yellowClr =Color(0xFFFFB746);
const Color pinkClr =Color(0xFFff4667);
const Color white = Colors.white;
const  primaryClr = bluishClr;
const  Color darkGreyClr = Color(0xFF121212);
  Color darkHeaderClr =  Color(0xFF424242);



class Themes{
 static final light = ThemeData(
   primaryColor: primaryClr,
   brightness: Brightness.light
 );
 // Dark theme works in this case =>
 // darkTheme: ThemeData.dark().copyWith(
 // colorScheme: ColorScheme.fromSwatch().copyWith(
 // primary: Colors.amberAccent)).
 static final dark = ThemeData(
   primaryColor:darkGreyClr,
   brightness: Brightness.dark
 );

}
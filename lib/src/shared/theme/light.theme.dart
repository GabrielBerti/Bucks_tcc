import 'package:flutter/material.dart';

const brightness = Brightness.light;
const lightColor = const Color(0xFFFFFFFF);

ThemeData lightTheme() {
  return ThemeData(
    // primarySwatch: primaryColor,
    brightness: brightness,
    // textTheme: new TextTheme(
    //   body1: new TextStyle(color: Colors.red),
    //   display4: new TextStyle(fontSize: 78),
    //   button: new TextStyle(color: Colors.green),
    //   headline: new TextStyle(color: Colors.deepPurple)
    // ),
    // tabBarTheme:
    // accentIconTheme:
    // accentTextTheme:
    // appBarTheme:
    // bottomAppBarTheme:
    // buttonTheme: new ButtonThemeData(
    //   buttonColor: Colors.orange,
    //   textTheme: ButtonTextTheme.primary,
    // ),
    // cardTheme: CardTheme(
    //   elevation: 5,
    //   color: Colors.indigo,
    // ),
    // chipTheme:
    // dialogTheme:
    // floatingActionButtonTheme:
    // iconTheme:
    // inputDecorationTheme:
    // pageTransitionsTheme:
    // primaryIconTheme:
    // primaryTextTheme:
    // sliderTheme:
    backgroundColor: Colors.white,
    primaryColor: Colors.teal[300],
    accentColor: Colors.blue[900],
    // fontFamily: 'Montserrat',
    //buttonColor: Colors.indigo,

    // // scaffoldBackgroundColor: backgroundColor,
    // cardColor: Colors.white,
  );
}

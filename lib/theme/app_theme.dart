import 'package:flutter/material.dart';

class AppTheme{

  static const Color primary = Colors.indigo;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
        // Color Primario
        primaryColor: Colors.indigo,
        //AppBar Theme
        appBarTheme: const AppBarTheme(
          color: primary,
          elevation: 0,
        ),

        //Text Button Theme

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: primary)
        ),

        //Floating Action Buttons
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          elevation: 5,

          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              shape: const StadiumBorder(),
              elevation: 0,
            )
          ),

          inputDecorationTheme: const InputDecorationTheme(
            floatingLabelStyle: TextStyle( color: primary ),
            
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide( color: primary ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              )
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide( color: primary ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              )
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10)
              )
            ),
          )

      );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
        // Color Primario
    primaryColor: Colors.indigo,
        //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),

    textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: primary)
        )


  );



}
import 'package:flutter/material.dart';
import 'package:custom_pull_to_refresh_app/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pull to Refresh App',
      theme: ThemeData(
        primaryColor: Color(0xFFb23a48),
        hintColor: Color(0xFFfcb9b2),
        scaffoldBackgroundColor: Color(0xFFfcb9b2),
        appBarTheme: AppBarTheme(
          color: Color(0xFF8c2f39),
          titleTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: HomeScreen(),
    );
  }
}

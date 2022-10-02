import 'package:flutter/material.dart';
import 'package:parcsmart_driver/login_provider/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      fontFamily: 'RobotoMono',
      primaryColor: Colors.black,
      primaryTextTheme: ThemeData.dark().textTheme.apply(
            fontFamily: 'RobotoMono',
          ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.teal,
        // color: Colors.white,
        centerTitle: true,
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(),
      // ),
      scaffoldBackgroundColor: const Color(0xffEDEDDC),
    ),
    home: const SignUpPage(),
  ));
}

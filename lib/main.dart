import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parcsmart_driver/login_provider/sign_in_page.dart';
import 'package:parcsmart_driver/login_provider/sign_up_page.dart';
import 'package:parcsmart_driver/map/custom_google_map.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.tinosTextTheme(Theme.of(context).textTheme.copyWith(
                bodyText2: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                bodyText1: const TextStyle(color: Colors.black38))),
        primarySwatch: Colors.teal,
        //   fontFamily: 'RobotoMono',
        primaryColor: Colors.black,
        primaryTextTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'RobotoMono',
            ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xff3DA886)),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
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
      home: const CustomGoogleMap(),
    );
  }
}
